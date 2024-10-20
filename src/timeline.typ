// Copyright Claudio Mattera 2023-2024.
//
// Distributed under the MIT License.
// See accompanying file License.txt, or online at
// https://opensource.org/licenses/MIT

#import "link.typ": draw_link, draw_literal_link
#import "theme.typ"
#import "icon.typ"

/// Draw a timeline bar
///
/// - start (ratio): The beginning of timeline.
/// - end (ratio): The ending of timeline.
/// - finished (boolean): True if the timeline has an end, false otherwise.
/// -> content: The timeline.
#let draw_bar(start: 0%, end: 100%, finished: true) = {
    context {
        let theme = theme.state.get()
        let bar_color = if finished {
            theme.color
        } else {
            gradient.linear(theme.color, white)
        }

        let radius = (
            top-left: theme.radius,
            bottom-left: if theme.style == "lighten" { theme.radius } else { 0pt },
            top-right: if finished { theme.radius } else { 0pt },
            bottom-right: if finished and theme.style == "lighten" { theme.radius } else { 0pt },
        )

        let colors = if theme.style == "lighten" {
            (
                bar: bar_color,
                background: theme.color.lighten(90%),
                baseline: white,
            )
        } else if theme.style == "underline" {
            (
                bar: bar_color,
                background: white,
                baseline: gray,
            )
        } else {
            panic("Unknown style '" + theme.style + "'")
        }

        let left_pad = start * theme.width
        let right_pad = if finished {
            (100% - end) * theme.width
        } else {
            0%
        }
        let remaining_width = (end - start) * theme.width

        let bar = stack(
            dir: ltr,
            rect(
                width: theme.width,
                height: theme.thickness,
                fill: colors.background,
            ),
            move(
                dx: -theme.width,
                stack(
                    dir: ltr,
                    h(left_pad),
                    rect(
                        width: remaining_width,
                        height: theme.thickness,
                        fill: colors.bar,
                        radius: radius,
                    ),
                )
            )
        )

        if theme.style == "lighten" {
            bar
        } else if theme.style == "underline" {
            stack(
                dir: ttb,
                bar,
                line(length: theme.width, stroke: 0.2pt + colors.baseline),
            )
        } else {
            panic("Unknown style '" + theme.style + "'")
        }
    }
}

/// Draw a text over a timeline bar
///
/// - position (ratio): The position of text over the timeline.
/// - above (boolean): True if the text should go above the timeline, false otherwise.
/// - label (str): The text to draw.
/// -> content: The text.
#let draw_text(position: 0%, above: true, label) = {
    context {
        let theme = theme.state.get()
        let position = position * theme.width
        let content = text(size: 7pt, fill: theme.color, [#label])
        let content_size = measure(content)
        pad(x: position - content_size.width / 2, block(width: content_size.width, content))
    }
}

/// Draw a timeline bar with years
///
/// - start (datetime): The beginning of timeline.
/// - end (datetime): The ending of timeline.
/// - label_start (str): The label for beginning of timeline (optional).
/// - label_end (str): The label for ending of timeline (optional).
/// - finished (boolean): True if the timeline has an end, false otherwise.
/// -> content: The timeline.
#let draw_year_bar(
    start: none,
    end: none,
    label_start: none,
    label_end: none,
    finished: true,
) = {
    context {
        let theme = theme.state.get()
        let start = if start == none {
            theme.base_date
        } else {
            start
        }
        let end = if end == none {
            theme.current_date
        } else {
            end
        }
        let label_start = if label_start == none {
            if finished {
                str(start.year())
            } else {
                "Since " + str(start.year())
            }
        } else {
            label_start
        }
        let label_end = if label_end == none {
            str(end.year())
        } else {
            label_end
        }
        let start_d = ((start - theme.base_date) / (theme.current_date - theme.base_date)) * 100%
        let end_d = ((end - theme.base_date) / (theme.current_date - theme.base_date)) * 100%

        if finished and start.year() != end.year() {
            grid(
                row-gutter: 1mm,
                draw_text(position: start_d, [#label_start]),
                draw_bar(start: start_d, end: end_d, finished: finished),
                draw_text(position: end_d, [#label_end]),
            )
        } else {
            grid(
                row-gutter: 1mm,
                draw_text(position: start_d, [#label_start]),
                draw_bar(start: start_d, end: end_d, finished: finished),
            )
        }
    }
}

/// Draw a timeline point with years
///
/// - date (datetime): The point of timeline.
/// - label (str): The label the timeline (optional).
/// -> content: The timeline.
#let draw_year_point(date: none, label: none) = {
    context {
        let theme = theme.state.get()
        let date = if date == none {
            theme.base_date
        } else {
            date
        }
        let label = if label == none {
            date.year()
        } else {
            label
        }

        let date_d = ((date - theme.base_date) / (theme.current_date - theme.base_date)) * 100%

        let left_pad = date_d * theme.width

        let radius = 130% * theme.thickness / 2

        let piece = if theme.style == "lighten" {
            stack(
                dir: ltr,
                rect(
                    width: theme.width,
                    height: theme.thickness,
                    fill: theme.color.lighten(90%),
                ),
                move(
                    dx: -theme.width,
                    stack(
                        dir: ltr,
                        h(left_pad),
                        move(
                            dy: (theme.thickness - 2 * radius) / 2,
                            circle(radius: radius, fill: theme.color),
                        ),
                    )
                )
            )
        } else if theme.style == "underline" {
            stack(
                dir: ltr,
                line(length: theme.width, stroke: 0.2pt + gray),
                move(
                    dx: -theme.width,
                    stack(
                        dir: ltr,
                        h(left_pad),
                        move(
                            dy: -radius,
                            circle(radius: radius, fill: theme.color),
                        ),
                    )
                )
            )
        } else {
            panic("Unknown style '" + theme.style + "'")
        }

        grid(
            row-gutter: 1mm,
            draw_text(position: date_d, [#label]),
            piece
        )
    }
}

/// Draw a textual entry
///
/// - title (str): The entry's title.
/// - content (content): The entry's content
/// -> content: The entry.
#let draw_entry(
    title,
    content,
) = {
    context {
        let theme = theme.state.get()
        set block(spacing: 0.9em)

        let bar = box(
            width: theme.width,
            align(right, text(hyphenate: false, [#title])),
        )

        grid(
            columns: (theme.width + 0.3cm, auto),
            bar,
            content,
        )
    }
}

/// Draw a textual entry next to a timeline
///
/// - start (datetime): The beginning of timeline.
/// - end (datetime): The ending of timeline.
/// - label_start (str): The label for beginning of timeline (optional).
/// - label_end (str): The label for ending of timeline (optional).
/// - finished (boolean): True if the timeline has an end, false otherwise.
/// - interval (boolean): True if the timeline is an interval between two dates, false otherwise.
/// - content (content): The entry's content
/// -> content: The entry.
#let draw_timeline_entry(
    start: none,
    end: none,
    label_start: none,
    label_end: none,
    finished: true,
    interval: true,
    content,
) = {
    context {
        let theme = theme.state.get()
        let bar = if interval {
            draw_year_bar(
                start: start,
                end: end,
                label_start: label_start,
                label_end: label_end,
                finished: finished,
            )
        } else {
            draw_year_point(date: start, label: label_start)
        }

        let bar = box(
            width: theme.width,
            bar,
        )

        block(
            above: 0.9em,
            below: 0.9em,
            grid(
                columns: (theme.width + 0.3cm, auto),
                bar,
                content,
            ),
        )
    }
}

/// Draw a work experience with a timeline
///
/// - start (datetime): The beginning of the experience.
/// - end (datetime): The ending of the experience.
/// - label_start (str): The label for beginning of timeline (optional).
/// - label_end (str): The label for ending of timeline (optional).
/// - finished (boolean): True if the experience has an end, false otherwise.
/// - interval (boolean): True if the experience is an interval between two dates, false otherwise.
/// - position (str): The name of the experience.
/// - company (str): The company name.
/// - city (str): The city.
/// - country (str): The country.
/// - url (str): The URL to the company website.
/// - content (content): The description of the experience.
/// -> content: The formatted experience.
#let draw_experience(
    start: none,
    end: none,
    label_start: none,
    label_end: none,
    finished: true,
    interval: true,
    position: "",
    company: "",
    city: "",
    country: "",
    url: "",
    content,
) = {
    let pieces = ()

    if position != "" {
        pieces.push(strong(position))
    }
    if company != "" {
        pieces.push(emph(company))
    }
    if city != "" {
        pieces.push(city)
    }
    if country != "" {
        pieces.push(country)
    }
    if url != "" {
        pieces.push(draw_literal_link(url))
    }

    let first_line = pieces.join(", ")

    draw_timeline_entry(
        start: start,
        end: end,
        label_start: label_start,
        label_end: label_end,
        interval: interval,
        finished: finished,
    )[#first_line
        #block(above: 0.6em)[#content]
    ]
}

/// Draw an education with a timeline
///
/// - start (datetime): The beginning of the education.
/// - end (datetime): The ending of the education.
/// - label_start (str): The label for beginning of timeline (optional).
/// - label_end (str): The label for ending of timeline (optional).
/// - finished (boolean): True if the education has an end, false otherwise.
/// - interval (boolean): True if the education is an interval between two dates, false otherwise.
/// - title (str): The title of the education.
/// - institution (str): The institution name.
/// - department (str): The department name.
/// - city (str): The city.
/// - country (str): The country.
/// - url (str): The URL to the institution website.
/// - content (content): The description of the education.
/// -> content: The formatted education.
#let draw_education(
    start: none,
    end: none,
    label_start: none,
    label_end: none,
    finished: true,
    interval: true,
    title: "",
    institution: "",
    department: "",
    city: "",
    country: "",
    url: "",
    content,
) = {
    let pieces = ()

    if title != "" {
        pieces.push(strong(title))
    }
    if institution != "" {
        pieces.push(emph(institution))
    }
    if department != "" {
        pieces.push(emph(department))
    }
    if city != "" {
        pieces.push(city)
    }
    if country != "" {
        pieces.push(country)
    }
    if url != "" {
        pieces.push(draw_literal_link(url))
    }

    let first_line = pieces.join(", ")

    draw_timeline_entry(
        start: start,
        end: end,
        label_start: label_start,
        label_end: label_end,
        interval: interval,
        finished: finished,
    )[#first_line
        #block(above: 0.6em)[#content]]
}

/// Draw a publication with a timeline
///
/// - date (datetime): The date of the publication.
/// - label_date (str): The label for the timeline (optional).
/// - title (str): The title of the publication.
/// - doi (str): The Digital Object Identifier of the publication.
/// -> content: The formatted publication.
#let draw_publication(
    date: none,
    label_date: none,
    title: "",
    doi: "",
) = {
    let url = "https://doi.org/" + doi
    let link = draw_literal_link(url, label: doi)

    draw_timeline_entry(
        start: date,
        label_start: label_date,
        interval: false,
    )[#title * #smallcaps([doi]): #link*]
}

/// Draw a language proficiency
///
/// - language (str): The language.
/// - level (str): The proficiency level.
/// - content (content): Free text description.
/// -> content: The formatted language proficiency.
#let draw_language(
    language,
    level,
    content,
) = {
    draw_entry(language)[
        #grid(
            columns: (20%, 80%),
            [#level],
            align(right, text(style: "italic", content)),
        )
    ]
}

/// Draw a list of projects on GitHub
///
/// Each project should be a dictionary with two fields:
/// * `name`: the project name, and
/// * `description`: the project description.
///
/// A third field, `slug`, can be used to rename a project.
/// The generated link will be to `https://github.com/{{ github }}/{{ project.slug }}`, while the displayed name will be `project.name`.
///
/// - github (str): The GitHub handle.
/// - projects (array): The list of projects.
/// -> content: The formatted list of projects.
#let draw_projects(
    github,
    projects,
) = {
    [Available on my #icon.github Github page: #draw_literal_link("https://github.com/" + github) ]

    grid(
        columns: (3.5cm, auto),
        column-gutter: 1em,
        row-gutter: 0.8em,
        ..projects.map(project => {
            let project_slug = project.at("slug", default: project.name)
            let project_link = "https://github.com/" + github + "/" + project_slug
            (
                align(right, strong(draw_link(project_link, project.name))),
                project.description,
            )
        }).flatten()
    )
}
