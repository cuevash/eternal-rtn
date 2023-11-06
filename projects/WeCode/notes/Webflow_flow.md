
# Webflow Flow

## Flow of a creatig a Webflow Project

### Create/Clone a base template

* From some base templates do a clone.
  * This base templates will have
    * Client-First - Styled Page and all the css for the default tags.
    * Some Common libs from the community (eg. untitled lib, Finsweet wireframe etc)
    * Our common libs (If that is possible!)

* Saved this -> Project v1.0 (Create/Clone Base styling project)

### Define global styling

* Styling
  * Colors
    * Review -> https://m3.material.io/styles/color/overview
      * To update and apply a color system that we can apply to apps and webs.
    * Primary palette
    * secondary palette
    * and tertiary and other palettes (if necessary)
    * Define black & white swatch colors. These colors represent the black and white colors of our project, and they may not be exactly the universal white and black. 
      * Called them, project-black and project-white.
  * Set the global styling for:
    * In Client-First, we limit body tag styles to typography and background-color properties.
    * All Bodys -> 
      * Typography
        * Default size (In Rem) 
        * Default Text color
      * Background
        * Default color (color surface based on a design system)
* Saved this -> Project v1.1 (Initial CMS skeleton)

### Create Sleketon Pages/Section

* Create some initial CMS collections (Just skeletons, do not need to be very complete, just names)

* Create some initial skeleton of pages and sections. Very simple ones. Just the names that identify the different pages, sections. Do not yet consider styling or differences between desktop and mobile etc.
Name each section with the nomenclature -> section_[section-name]. The name should be unique for the whole project.

*[TO_UPDATE] Those sections that get repeated should be converted to symbols

### Fleshing out the pages/sections

* Using a system design approach, for the different elements we will start creating the atoms, the molecules and components that are going to be reused on the project.
* Add sufficiently generic components to the generic components' library. So they can be reused on future projects.

* Crate NavBar 
  * Make it symbol
  * Create/define the different aspects for all the possible aspect ratios (Desktop, tablet, mobile, etc...)

* Crate Footer 
  * Make it symbol
  * Create/define the different aspects for all the possible aspect ratios (Desktop, tablet, mobile, etc...)

* Just the work of making the pages/sections. 
* Possible common styling should be following the Client-First conventions. On this way it increases the possibility of being reused.



## Resources

### Design systems

* General
  * <https://uxdesign.cc/everything-you-need-to-know-about-design-systems-54b109851969>
  * <https://atomicdesign.bradfrost.com/>
  * Published by Figma <https://www.designsystems.com/>

* Advanced examples of design systems for web apps and web
  * Material <https://m3.material.io/>
  * Eva Design <https://eva.design/?utm_campaign=eva_design%20-%20home%20-%20ui_kitten%20docs&utm_source=ui_kitten&utm_medium=referral&utm_content=what_is_kitten_top_link>

* Font tools
  * https://type-scale.com/ 

* Colors
  * Defining colors in your design system <https://uxdesign.cc/defining-colors-in-your-design-system-828148e6210a>
  * Tools to help create a palette of colors
    * <https://colors.eva.design/>
    * <https://coolors.co/>

### Webflow

* General <https://university.webflow.com/lesson>
* finsweet -> <https://www.finsweet.com/> (Lots of interesting videos on youtube )

* Create Consistency Across your Webflow Website with a Design System <https://www.nikolaibain.com/blog/webflow-design-system>

* Client First <https://www.finsweet.com/client-first/> (we will base our structure mainly on this one)
* Knockout <https://www.madewithknockout.com/knockout-framework/setting-up-knockout/>

