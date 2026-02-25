# edi810

A zero-dependency Ruby library for parsing, generating, and validating
ANSI X12 EDI 810 Invoice transaction sets.

## EDI 810 Structure (ANSI X12)

An EDI 810 document is wrapped in envelope segments and contains three areas: Header, Detail, and Summary.

- **Envelope:** ISA (Interchange Control Header), GS (Functional Group Header), ST (Transaction Set Header), SE (Transaction Set Trailer), GE (Group Trailer), IEA (Interchange Trailer)
- **Header segments:** BIG (Beginning Segment for Invoice -- invoice date, invoice#, PO date, PO#), NTE (Notes), CUR (Currency), REF (Reference), PER (Contact), N1 Loop (N1/N2/N3/N4 -- party name/address), ITD (Terms of Sale), DTM (Date/Time), FOB
- **Detail segments:** IT1 Loop -- IT1 (line item: qty, UOM, unit price, product IDs), PID (description), REF, SAC (charges/allowances), TXI (tax), DTM, SLN (subline items)
- **Summary segments:** TDS (total monetary values), TXI, CAD (carrier), SAC Loop, ISS (shipment summary), CTT (transaction totals: line count + hash)
- **Delimiters** are auto-detected from ISA segment: element separator (ISA[3]), sub-element separator (ISA[104]), segment terminator (ISA[105]).

## Features

- **Parse** EDI 810 documents into structured Ruby objects
- **Generate** EDI 810 from Ruby objects with configurable delimiters
- **Validate** structural integrity, required elements, control numbers, and CTT totals
- **Auto-detect** element separator, sub-element separator, and segment terminator from the ISA header
- **All 52 segment types** from the X12 810 specification
- **Round-trip fidelity** -- parse and regenerate without data loss
- **Zero runtime dependencies** -- pure Ruby, works with Ruby >= 3.0

## Design Decisions

- **Zero dependencies** — pure Ruby, no external gems required at runtime
- **Auto-detect delimiters** from the ISA segment (positions 3, 104, 105 of the raw ISA line). Default: * element sep, : sub-element sep, ~ segment terminator
- **Segment classes** inherit from `Edi810::Segment` base class, which provides `#to_h`, `#to_edi`, element accessors via DSL, and type coercion
- **Loops** are plain Ruby objects grouping related segments with iteration support
- **Parser** is a single-pass state machine: reads tokens sequentially, tracks current area (envelope/header/detail/summary), and builds the `Document`
- **Validator checks:** mandatory segments present, element data types (AN/ID/DT/TM/N/R), min/max lengths, structural ordering, CTT line count matches IT1 count
- **Generator** serializes Document back to EDI string with configurable delimiters
- **Immutable segments** -- once parsed, segment data is frozen. Mutations go through builder/generator.

## Installation

Add to your Gemfile:

```ruby
gem "edi810"
```

Or install directly:

```
gem install edi810
```

## Quick Start

### Parsing

```ruby
require "edi810"

doc = Edi810.parse(File.read("invoice.edi"))
# or
doc = Edi810.parse_file("invoice.edi")

# Invoice header
doc.invoice_number        # => "INV-001"
doc.invoice_date          # => #<Date: 2021-03-15>
doc.purchase_order_number # => "PO-12345"
doc.total_amount          # => 52363 (BigDecimal)

# Sender/receiver
doc.sender_id             # => "SENDER"
doc.receiver_id           # => "RECEIVER"

# Line items
doc.line_items.each do |item|
  item.line_number        # => "1"
  item.quantity           # => 10 (BigDecimal)
  item.unit_of_measure    # => "EA"
  item.unit_price         # => 25.50 (BigDecimal)
  item.product_id         # => "012345678901"
  item.description        # => "Widget Type A"
end

# Parties (N1 loops)
bill_to = doc.bill_to     # shortcut for doc.party("BT")
bill_to.name              # => "Acme Corp"
bill_to.city              # => "New York"
bill_to.state             # => "NY"
bill_to.postal_code       # => "10001"

ship_to = doc.ship_to     # doc.party("ST")
remit_to = doc.remit_to   # doc.party("RE")

# Or look up any party by code
doc.party("SF")           # Ship From
```

### Validation

```ruby
result = Edi810.validate(doc)

if result.valid?
  puts "Document is valid"
else
  result.errors.each do |error|
    puts "#{error.segment_id}: #{error.message} (#{error.code})"
  end
end
```

Validation checks include:
- Mandatory segments present (ISA, GS, ST, BIG, TDS, SE, GE, IEA)
- Required elements within each segment
- Element min/max length constraints
- ST02/SE02 control number match
- GS06/GE02 control number match
- ISA13/IEA02 control number match
- SE01 segment count accuracy
- CTT01 line item count matches actual IT1 count
- CTT02 hash total matches sum of IT102 quantities

### Generation

```ruby
# Regenerate from a parsed document (preserves original delimiters)
edi_string = Edi810.generate(doc)

# Use custom delimiters
edi_string = Edi810.generate(doc,
  element_separator: "*",
  segment_terminator: "~",
  line_ending: "\n"
)
```

### Accessing Raw Segments

Every segment exposes its parsed elements via named accessors and a `to_h` method:

```ruby
big = doc.big
big.invoice_date                    # => #<Date: 2021-03-15>
big.invoice_number                  # => "INV-001"
big.to_h                            # => { invoice_date: ..., invoice_number: "INV-001", ... }
big.to_edi                          # => "BIG*20210315*INV-001*20210301*PO-12345"

# Full document as hash
doc.to_h
```

## Supported Segments

All 52 segment types from the X12 810 specification:

**Envelope:** ISA, GS, ST, SE, GE, IEA

**Header:** BIG, NTE, CUR, REF, YNQ, PER, N1, N2, N3, N4, DMG, ITD, DTM, FOB,
PID, MEA, PWK, PKG, L7, BAL, INC, PAM, CRC, MTX, LM, LQ, N9, MSG, V1, R4, FA1, FA2

**Detail:** IT1, QTY, IT3, TXI, CTP, PO4, SDQ, CAD, SR, SAC, SLN

**Summary:** TDS, ISS, CTT

## Loops

The parser recognizes and structures these loop hierarchies:

- **N1 Loop** -- N1 + N2/N3/N4/REF/PER/DMG (party name/address)
- **IT1 Loop** -- IT1 + all detail child segments and sub-loops
- **SAC Loop** -- SAC + TXI (charges/allowances with tax)
- **PID Loop** -- PID + MEA (product description with measurements)
- **SLN Loop** -- SLN + DTM/REF/PID/SAC (subline items)
- **LM Loop** -- LM + LQ (code source)
- **N9 Loop** -- N9 + MSG (extended reference)
- **V1 Loop** -- V1 + R4/DTM (vessel identification)
- **FA1 Loop** -- FA1 + FA2 (financial accounting)

## Development

```
bundle install
bundle exec rspec
```

## License

MIT
