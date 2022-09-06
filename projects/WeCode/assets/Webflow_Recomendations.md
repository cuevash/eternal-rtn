
# Webflow Recomendations

## Sections structure a page

- It is a good idea to start creating the sections that will make the page.

- This is the level that will probably be most used to create templates that would be used through the webpage. 
  - On the section of elements there is a layout area full of created very common section components. These components can be out starting point to customize it to whatever we want.
  - If a section gets repeated then it is better to create a symbol (template).

- Symbols are a great tool. They are basically template of a group of elements together. It is quite common to create Symbols for sections. But you can create Symbols of even a single component. If you create a component and customized a lot and then use it several times, then that's the perfect use case for symbols. 

- Sections, at least in Webflow, are top components of the page. They can only be at the top, and they cannot be nested.

## CSS Classes

- Don't create a huge hierarchy of classes. 
- Every symbol likely will create classes for each of the grouping and elements inside the symbol. 
- This will help to identify which styles are applied at each level of the hierarchy grouping.
- Class helps create consistency on the styles.
  - When you change a class all elements with that class get updated at the same time.
- When and what to use classes for ?
- Global Styles

## Style System - Client First (Finsweet)

Client First -> Client-First is a set of guidelines and strategies to help us build Webflow websites.

<https://www.finsweet.com/client-first/>

### Naming Convention

## Things to Investigate

- How to handle blocks or elements that need several utility classes? If we are going to avoid the use of deep stacking, then, which alternative method can we use.

## Webs to consider for our web

- <https:/>/www.relume.io/>
- <https://www.finsweet.com/>
- Connection to APIs and data -> https://www.wized.io/#features

## Structure Videos

- Client First : <https://www.youtube.com/watch?v=efTUjiNp7SE&t=2s&ab_channel=Finsweet>
- Symbols - Macros -> <https://www.youtube.com/watch?v=NiQW31R6JKk&ab_channel=Finsweet>