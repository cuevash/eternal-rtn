# LOG

## 2023-09-01

* The purpose of this project is to recreate the SingularFact web using Figma and Client-First.
* Goals:
  * Better sync between designers and webflow programmer
  * Establish a workflow that can resused for most of the web projects
  * Establish a way to identify in a project:
    * Colors (Primary, secondary , etc)
    * Text styles, principally sizes
    * Others standard things
    * How to translate hero sections into Webflow using client-first with the minimum work possible.
  * New goals to achieve in the near future.

* Bring the font poppings into Webflow

## 2023-09-02

* What to define in Figma?
  * Text styles
    * All but size. Size should be done independently
    * Size should be one of the text sizes defined.
  * Text sizes
    * Define a list of text sizes like
      * tiny, small, regular, medium, large, xlarge, xxlarge... etc
    * Dont use auto height line -> Dont know what it means..  
  * Define text sizes and standard styles for h1,h2, h3, paragraph
  * Colors
    * Define colors palettes like in a design system, depending on the complexity of the web.
      * Blue_100, Blue_200 or Blue_1, Blue_2, Blue_Light, Blue_Dark
      * Also is a good idea to have sometimes colors in teh design system like:
        * Primary_100, Primary_200, Primary_Light, Primary_Dark, Secondary, Alt, etc
  * Sections with clear margins
    * On the sides
    * On top y bottom
    * Clarify total size y minimum padding to browser
  * Everything in sections with clear relations between them. No absolute positioning in big sections.
  big sections are transformed into smaller ones.
  * Try to use standard aspect ratios 16-9 4-3 etc..
  * Think about how would you like the elements to behave related to the size (width) of the screen (browser/device)
