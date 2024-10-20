// Copyright Claudio Mattera 2023-2024.
//
// Distributed under the MIT License.
// See accompanying file License.txt, or online at
// https://opensource.org/licenses/MIT

#import "icon.typ"
#import "timeline.typ": draw_bar
#import "link.typ": draw_literal_link
#import "theme.typ"

/// Draw the full name on header left column
///
/// - fullname (str): Your full name.
/// -> content: The header left column.
#let draw_name(fullname) = {
    grid(
        rows: (auto, auto),
        row-gutter: 20pt,
        text(
            size: 34pt,
            par(
                leading: 10pt,
                [#fullname],
            ),
        ),
        text(
            fill: gray.darken(20%),
            style: "italic",
            size: 15pt,
            [Curriculum Vitae],
        )
    )
}

/// Draw the personal information on header right column
///
/// - address (str): Your home address (optional).
/// - phone (str): Your phone number (optional).
/// - email (str): Your email address (optional).
/// - website (str): Your website URL (optional).
/// - linkedin (str): Your linkedin handle (optional).
/// - github (str): Your github handle (optional).
/// - orcid (str): Your orcid number (optional).
/// -> content: The header right column.
#let draw_personal_information(
    address: none,
    phone: none,
    email: none,
    website: none,
    linkedin: none,
    github: none,
    orcid: none,
) = {
    let pieces = ()

    if address != none {
        pieces.push([#icon.house #address])
    }
    if phone != none {
        pieces.push(
            link("tel:" + phone, icon.phone + " " + phone)
        )
    }
    if email != none {
        pieces.push(
            link("mailto:" + email, icon.mail + " " + email)
        )
    }
    if website != none {
        pieces.push(
            link("https://" + website, icon.world + " " + website)
        )
    }
    if linkedin != none {
        pieces.push(
            link("https://www.linkedin.com/in/" + linkedin, icon.linkedin + " " + linkedin)
        )
    }
    if github != none {
        pieces.push(
            link("https://github.com/" + github, icon.github + " " + github)
        )
    }
    if orcid != none {
        pieces.push(
            link("https://orcid.org/" + orcid, icon.orcid + " " + orcid)
        )
    }

    align(
        right,
        text(
            fill: gray.darken(20%),
            style: "italic",
            size: 9pt,
            grid(
                row-gutter: 4pt,
                columns: (auto),
                ..pieces
            )
        )
    )
}

/// Configure the document and typeset the header
///
/// - fullname (str): Your full name.
/// - address (str): Your home address (optional).
/// - phone (str): Your phone number (optional).
/// - email (str): Your email address (optional).
/// - website (str): Your website URL (optional).
/// - linkedin (str): Your linkedin handle (optional).
/// - github (str): Your github handle (optional).
/// - orcid (str): Your orcid number (optional).
/// - doc (content): The rest of the document.
/// -> content: The formatted document.
#let conf(
    fullname: "",
    address: none,
    phone: none,
    email: none,
    website: none,
    linkedin: none,
    github: none,
    orcid: none,
    doc,
) = {
    set par(
        justify: true,
        leading: 0.5em,
    )

    set text(
        font: "TeX Gyre Adventor",
        size: 9pt,
    )

    show heading: it => {
        context {
            let theme = theme.state.get()
            set block(below: 1em)

            grid(
                columns: (theme.width + 0.35cm, auto),
                align(
                    horizon,
                    rect(
                        width: theme.width,
                        height: 2mm,
                        fill: theme.color,
                    ),
                ),
                text(
                    fill: theme.color,
                    it.body,
                )
            )
        }
    }

    let name = draw_name(fullname)

    let personal_information = draw_personal_information(
        address: address,
        phone: phone,
        email: email,
        website: website,
        linkedin: linkedin,
        github: github,
        orcid: orcid,
    )

    grid(
        columns: (70%, 30%),
        name,
        personal_information
    )

    v(1fr)

    doc
}
