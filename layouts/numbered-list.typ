#let layout-numbered-list(data, isbreakable: true) = {
  // Set width for the number column
  let number_width = 2em

  block(width: 100%, breakable: isbreakable)[
    // Check if data is an array (direct list of citations)
    #if type(data) == array {
      let entries_num = data.len()
      for (index, entry) in data.enumerate() {
        // Create a grid with two columns
        grid(
          columns: (number_width, 1fr),
          gutter: 1em,

          // Right-aligned number in the first column
          align(right)[*[#(entries_num - index)]*],

          // Citation text with markup in the second column

          grid(
            rows: 3,
            gutter: .65em,
            [*#entry.title*],
            text(
              eval(entry.authors, mode: "markup"),
              style: "italic",
            ),
            if "submit-to" in entry and entry.submit-to != "" {
              if entry.submit-type == "journal" {
                [_*[J] #entry.submit-to*, #entry.submit-details _ (*#entry.short-name*)]
              } else if entry.submit-type == "conference" {
                let details = if entry.at("submit-details", default: "") != "" { [, #entry.submit-details] }
                let doi = if entry.at("doi", default: "") != "" { [. DOI: #link("https://doi.org/" + entry.doi)[#entry.doi]] }
                [_*[C]* #entry.submit-to _ (*#entry.short-name*)#details#doi]
              } else {
                ""
              }
            } else {
              text(style: "italic")[Submitted]
            },
          ),
        )
        // Keep entry spacing independent of the number of metadata fields.
        v(1.3em)
      }
    } else {
      [No entries found]
    }
  ]
}
