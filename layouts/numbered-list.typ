#let layout-numbered-list(data, isbreakable: true) = {
  // Set width for the number column
  let number_width = 2em

  block(width: 100%, breakable: isbreakable)[
    // Check if data is an array (direct list of citations)
    #if type(data) == array {
      for (index, entry) in data.enumerate() {
        // Create a grid with two columns
        grid(
          columns: (number_width, 1fr),
          gutter: 1em,

          // Right-aligned number in the first column
          align(right)[*[#(index + 1)]*],

          // Citation text with markup in the second column
          grid(
            rows: entry.len(),
            gutter: 1em,
            [*#entry.title*],
            text(
              eval(entry.authors, mode: "markup"),
              style: "italic",
            ),
            if "submit-to" in entry and entry.submit-to != "" {
              if entry.submit-type == "journal" {
                [*[J] #entry.submit-to*, #entry.submit-details]
              } else if entry.submit-type == "conference" {
                [*[J] #entry.submit-to*, #entry.submit-details]
              } else {
                ""
              }
            } else {
              text(style: "italic")[Submitted]
            },
          ),
        )

        // Add space between entries
        if index < data.len() - 1 {
          v(0.05em)
        }
      }
    } else {
      [No entries found]
    }
  ]
}
