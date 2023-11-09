// Copyright Claudio Mattera 2023.
//
// Distributed under the MIT License.
// See accompanying file License.txt, or online at
// https://opensource.org/licenses/MIT

#import "../src/lib.typ": conf, configure_theme, draw_education, draw_experience, draw_publication, draw_entry, draw_language, draw_projects

#configure_theme(
    color: rgb("#377eb8"),
    base_date: datetime(year: 2013, month: 1, day: 1),
    current_date: datetime(year: 2024, month: 1, day: 1),
)

#show: doc => conf(
    fullname: "John Doe",
    address: "Southern Pole, Antarctica",
    phone: "+672 123 456 789",
    email: "jobs@johndoe.aq",
    website: "johndoe.aq",
    github: "johndoe",
    orcid: "0000-0000-0000-0000",

    doc,
)


= Education

#draw_education(
    start: datetime(year: 2015, month: 8, day: 1),
    end: datetime(year: 2019, month: 4, day: 1),
    title: "Ph. D. in Software Engineering",
    institution: "University of Antarctica",
    department: "Ice Caps Office",
    city: "Southern Pole",
    country: "Antarctica",
    url: "https://www.icecap.aq/",
)[
My topic was designing and implementing software solutions for estimating thickness in ice caps by analysing their transparency.
]

#draw_education(
    start: datetime(year: 2013, month: 9, day: 1),
    end: datetime(year: 2015, month: 6, day: 1),
    title: "Master's Degree in Mathematics",
    institution: "University of Antarctica",
    city: "Southern Pole",
    country: "Antarctica",
)[]



= Work Experience

#draw_experience(
    start: datetime(year: 2021, month: 2, day: 1),
    finished: false,
    position: "Developer",
    company: "Southern Pole Express",
    city: "Southern Pole",
    country: "Antarctica",
    url: "https://www.southern-pole.aq/",
)[
I am in charge of the team leading excavation and extraction of samples from ice caps.
I use simulations to locate the areas where ice caps are thinner, in order to minimize the effort of excavation for reaching the bottom layers.
]

#draw_experience(
    start: datetime(year: 2019, month: 4, day: 1),
    end: datetime(year: 2021, month: 2, day: 1),
    label_start: "Years ago",
    position: "Research Assistant",
    company: "University of Antarctica",
    city: "Southern Pole",
    country: "Antarctica",
    url: "https://www.icecap.aq/",
)[
I took a six-months leave from my Ph. D. to carry out additional work at the department.
]


= Publications

#draw_publication(
    date: datetime(year: 2018, month: 1, day: 1),
    title: "A Method for Estimating Thickness in Ice Caps by Shining Light into Them and Squinting your Eyes",
    doi: "10.0999/aq.123457",
)

#draw_publication(
    date: datetime(year: 2016, month: 1, day: 1),
    label_date: "Start of Ph. D.",
    title: "Estimating Thickness in Ice Caps, a Survey of the State-of-the-art",
    doi: "10.0999/aq.123456",
)

= Personal Projects

#let personal_projects = (
    (name: "ice-cap-analyser", description: "Rust application for analysing thickness of ice caps"),
    (name: "modern-cv", description: "A Typst template for modern, good-looking curriculum vitæ"),
)

#draw_projects("johndoe", personal_projects)



= Academic Projects

#draw_entry("Master's Thesis")[
*Methods for Analysing Thickness of Ice Caps* \
I designed and implemented methods for estimating the thickness of ice caps from properties measurable from the surface, such as the reflectiveness of ice.
]


= Other Experiences

#draw_experience(
    start: datetime(year: 2017, month: 1, day: 1),
    end: datetime(year: 2019, month: 1, day: 1),
    position: "Member of the Academy Council",
    company: "Technical Faculty, University of Antarctica",
)[
The council oversees scientific hiring and evaluation of Ph. D. degrees at the faculty.
]


= Languages

#draw_language("Antarctic", "Native")[]
#draw_language("English", "Fluent")[Several years working in international environments in multiple countries]


= Computer Skills

#draw_entry("Platforms")[Linux, Windows]
#draw_entry("Languages")[Rust, Typst]


= Hobbies and Other Interests

#draw_entry("Skying")[I like to make long trips, and also to sky everyday]
#draw_entry("Boardgames")[I like to play quick party games, and also long, intricate boardgames]
