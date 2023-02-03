# Webflow Workflow

## Global Styles

* Responsive fluid
  * Most of the time it makes sense to add responsive fluid characteristics to the webs. In order to
  do that use the Finsweet plugin to create the CSS lines to be added to the **Global Styles** component.
  Ex:

```css
/* Fluid Responsive */
html { font-size: calc(0.625rem + 0.41666666666666663vw); }
@media screen and (max-width:1920px) { html { font-size: calc(0.625rem + 0.41666666666666674vw); } }
@media screen and (max-width:1440px) { html { font-size: calc(0.8126951092611863rem + 0.20811654526534862vw); } }
@media screen and (max-width:479px) { html { font-size: calc(0.7494769874476988rem + 0.8368200836820083vw); } }

```

## How to handle Menus

There are a few strategies to handle data in menus, depending on where the data is coming from.

* There is no relationship to any DB/CMS data. The entries of the menu are mostly unrelated.
In this case we just create the menu directly with the dropdown/select entries on webflow.

* It is related to active values on some table column.
In this case we connected with CMS Select to get all values, filtering them by the active criteria.

* It is a subset of some active values on some table column.

* Where to add the 'All' menu entry?
  * DB/CMS?
  * Webflow interface
  * Script?

## FAQ

### How to use current state in a collection page

* General case -> <https://d.pr/v/M8w4iI>
* In a navbar -> <https://discourse.webflow.com/t/can-i-set-a-current-state-on-buttons-inside-a-collection-list/55259/8>

> I gave each of the main nav menu items (inside a symbol for me) an ID eg #menu-item-articles
Then in the custom code for the CMS Collection Page template I added the following script before the body tag:

```javascript

var Webflow = Webflow || [];
Webflow.push(function() {
$('#menu-item-articles').addClass("w--current");
});

```

### How to eliminate auto-generated columns

* All elements children set to auto in 'grid child'
* On top of that if any of your grid children have a span greater than your desired number of columns/rows you’ll wind up with auto-generated fields, despite all elements being set to position auto, because the grid is trying to accommodate that span. Double check those grid children my friends, hopefully this’ll save you some gray hairs.
