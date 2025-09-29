#let layout-numbered-list(data, isbreakable: true) = {
  // Set width for the number column
  let number_width = 2em
  v(4pt)

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
            rows: entry.len(),
            gutter: 1em,
            [*#entry.title*],
            text(
              eval(entry.authors, mode: "markup"),
              style: "italic",
            ),
            if "submit-to" in entry and entry.submit-to != "" {
              if entry.submit-type == "journal" {
                [_*[J] #entry.submit-to*, #entry.submit-details _]
              } else if entry.submit-type == "conference" {
                [_*[C] #entry.submit-to*, #entry.submit-details _]
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
