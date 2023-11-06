Hi Daniel,

After reviewing your request, it appears that achieving what you want in Excel may not be simple, and you may need to use more complex methods such as relationships between tables and PivotTables that use multiple tables.

I propose a few approaches that will keep the solutions relatively simple and should more or less achieve your desired outcome.

One option is to simplify the goal by assigning each company a single category that you can call the MainCategory, or you could assign two categories like MainCategory and SecondCategory. To do this, you can extract the first and second categories from the list_categories and create one or two additional columns, depending on whether you want to add just one Main category or two.

In the PivotTable, you can then use the MainCategory as a filter, or if you added two categories, you can have two filters for the MainCategory and SecondaryCategory.

This approach should be acceptable and will not unnecessarily complicate the exercise.

Another option is to duplicate all of the company entries, one for each category. Then, in the PivotTable, you can summarize (group) by the company name and choose a function such as Min(Field) or Max(Field) that returns a single value for all the repeated rows with the same company.

The third option is more complex and involves creating another table with only the categories and a column that uniquely identifies each company. Then, you will need to create a PivotTable with multiple tables and relationships.

However, I do not recommend this option as it can be quite tricky to make it work.

I suggest that you go with one of the simpler options instead.

Cheers.

6.1.03

Buenos días, Juan y Gimena,

Como hablamos, podríamos tener la primera reunión con el cliente el viernes de la próxima semana, día 28, entre las 9:00 y las 15:00, cuando os venga mejor.

Entiendo que la reunión será por Teams, ¿es así? Si ese es el caso, quizás vosotros podríais crear la convocatoria para todos.

Un saludo,

Héctor Cuevas
