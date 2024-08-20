# Excel Formula

## Date and Time Formulas

| Formula         | Description                            |
| :-------------- | :------------------------------------- |
| =NOW            | Show the date and Time                 |
| =TODAY()        | Show the current Date without the Time |
| =DAY(TODAY())   | Show today's Date in a Cell            |
| =MONTH(TODAY()) | Show current month in a Cell           |
| =TODAY() + 10   | Add 10 days to the current Date        |

## Counting and Rounding Formulas

| Formula        | Description                                                          |
| :------------- | :------------------------------------------------------------------- |
| =COUNT         | Counts the number of non-blank Cells in given range                  |
| =COUNTA(A1:A5) | Counts the number of non-blank Cells in given range                  |
| =COUNTIF       | Counts the number of non-blank Cells in given range if condition met |
| =ROUND         | Rounds a number to a specified decimal places                        |
| =INT           | Truncates the decimal part of a number                               |
| =IF            | Test for True of False condition                                     |
| =TRUE          | Returns the logical value True                                       |
| =FALSE         | Returns the logical value False                                      |
| =AND           | Returns True if all arguments are True                               |
| =OR            | Returns True if any arguments is True                                |

## Unit Conversion Formulas

| Formula                    | Description                       |
| :------------------------- | :-------------------------------- |
| =CONVERT(A1, "DAY", "HR")  | Days to Hours                     |
| =CONVERT(A1, "HR", "MN")   | Hours to Minutes                  |
| =CONVERT(A1, "YR", "DAY")  | Years to Days                     |
| =CONVERT(A1, "MI", "KM")   | Miles to Kilometers               |
| =CONVERT(A1, "IN", "FT")   | Inches to Feets                   |
| =CONVERT(A1, "CM", "IN")   | Centimeters to Inches             |
| =CONVERT(A1, "C", "F")     | Celsius to Fahrenheit             |
| =CONVERT(A1, "TSP", "TBS") | Teaspoons to Tablespoons          |
| =CONVERT(A1, "GAL", "LT")  | Gallons to Liters                 |
| =BIN2DEC(1100100)          | Binary (1100100) to Decimal (100) |
| =ROMAN(5)                  | Decimal (5) to Roman (V)          |

## Mathematics Formulas

| Formula           | Description                                                           |
| :---------------- | :-------------------------------------------------------------------- |
| =SUM              | Calculates the Sum of a group of values                               |
| =SUMIF            | Calculates a Sum from a group of values in which condition met        |
| =AVERAGE          | Calculates the Mean of a group of values                              |
| =B2-C9            | Subtracts values in the two cells                                     |
| =D8*A3            | Multiplies the numbers in the two cells                               |
| =PRODUCT(A1:A19)  | Multiplies the cells in the range                                     |
| =PRODUCT(F6:A1,2) | Multiplies the cells in the range, and multiplies the result by 2     |
| =A1/A3            | Divides value in A1 by the value in A3                                |
| =MOD              | Returns the remainder from division                                   |
| =MIN(A1:A8)       | Calculates the smallest number in a range                             |
| =ODD              | Rounds a number up to the nearest odd integer                         |
| =EVEN             | Rounds a number up to the nearest even integer                        |
| =MEDIAN           | Separate range into half                                              |
| =SQRT             | Calculates the Square root of a number                                |
| =PI               | Returns the value of a PI                                             |
| =POWER            | Raise the first number by second number                               |
| =POWER(9,2)       | Calculates nine squared                                               |
| =9^3              | Calculates nine cubed                                                 |
| =RAND             | Get a random number                                                   |
| =RANDBETWEEN      | Get a random number between given range                               |
| =MAX(C27:C34)     | Calculates the largest number in a range                              |
| =SMALL(B1:B7, 2)  | Calculates the second smallest number in a range                      |
| =LARGE(G13:D7,3)  | Calculates the third largest number in a range                        |
| =FACT(A1)         | Factorial of value in A1                                              |
| =COS              | Calculates the cosine of the given angle                              |
| =SIN              | Calculates the sine of the given angle                                |
| =TAN              | Calculates the tangent of a number                                    |
| =CORREL           | Calculates the correlation coefficient between two data sets          |
| =STDEVA           | Estimates standard deviation based on a sample                        |
| =PROB             | Returns the probability that values in a range are between two limits |

## Text Formulas

| Formula      | Description                                                          |
| :----------- | :------------------------------------------------------------------- |
| =LEFT        | Extracts one or more characters from the left side of a text string  |
| =RIGHT       | Extracts one or more characters from the right side of a text string |
| =MID         | Extracts characters from the middle of a text string                 |
| =CONCATENATE | Merges two or more text strings                                      |
| =REPLACE     | Replaces part of a text string                                       |
| =TEXT        | Formats a number and converts it to text                             |
| =VALUE       | Converts a text cell to a number                                     |
| =EXACT       | Checks to see if two text values are identical                       |
| =LOWER       | Converts a text string to all lowercase                              |
| =UPPER       | Converts a text string to all uppercase                              |
| =PROPER      | Converts a text string to proper case                                |
| =LEN         | Returns a text string's length in characters                         |
| =REPT        | Repeats text a given number of times                                 |
| =DOLLAR      | Converts a number to text, using the USD currency format             |
| =CLEAN       | Removes all non-printable characters from text                       |

## Finance Formulas

| Formula     | Description                                                                                            |
| :---------- | :----------------------------------------------------------------------------------------------------- |
| =INTRATE    | Calculates the interest rate for a fully invested security                                             |
| =EFFECT     | Calculates the effective annual interest rate                                                          |
| =FV         | Calculates the future value of an investment                                                           |
| =FVSCHEDULE | Calculates the future value of an initial principal after applying a series of compound interest rates |
| =PMT        | Calculates the total payment (debt and interest) on a debt security                                    |
| =IPMT       | Calculates the interest payment for an investment for a given period                                   |
| =ACCRINT    | Calculates the accrued interest for a security that pays periodic interest                             |
| =ACCRINTM   | Calculates the accrued interest for a security that pays interest at maturity                          |
| =AMORLINC   | Calculates the depreciation for each accounting period                                                 |
| =NPV        | Calculates the net present value of cash flows based on a discount rate                                |
| =YIELD      | Calculates the yield of a security based on maturity, face value, and interest rate                    |
| =PRICE      | Calculates the price per $100 face value of a periodic coupon bond                                     |

## Chart Options

| Chart Types  | Description                                                                                                                                            |
| :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Column       | Used to compare different values vertically side-by- side. Each value is represented in the chart by a vertical bar.                                   |
| Line         | Used to illustrate trends over time (days, months, years). Each value is plotted as a point on the chart and values are connected by a line.           |
| Pie          | Useful for showing values as a percentage of a whole when all the values add up to 100%. The values for each item are represented by different colors. |
| Bar          | Similar to column charts, except they display information in horizontal bars rather than in vertical columns.                                          |
| Area         | Similar to line charts, except the areas beneath the lines are filled with color.                                                                      |
| XY (Scatter) | Used to plot clusters of values using single points. Multiple items can be plotted by using different colored points or different point symbols.       |
| Stock        | Effective for reporting the fluctuation of stock prices, such as the high, low, and closing points for a certain day.                                  |
| Surface      | Useful for finding optimum combinations between two sets of data. Colors and patterns indicate values that are in the same range.                      |

## Intermediate Formulas

| Formula                    | Description                                                                                                                                                                                                                    |
| :------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Absolute References        | Absolute references always refer to the same cell, even if the formula is moved. In the formula bar, add dollar signs $ to the reference you want to remain absolute (e.g. $A$1 makes the column and row remain constant).     |
| Name a Cell or Range       | Select the cell(s), click the Name box in the Formula bar, type a name for the cell or range, and press Enter. Names can be used in formulas instead of cell addresses, e.e.: =B4*Rate.                                        |
| Reference Other Worksheets | To reference another worksheet in a formula, add an exclamation point ! after the sheet name in the formula, e.g.: =FebruarySales!B4.                                                                                          |
| Reference Other Workbooks  | To reference another workbook in a formula, add brackets [] around the file name in the formula, e.g.: =[FebruarySales.xlsx]Sheet1!$B$4.                                                                                       |
| Order of Operations        | When calculating a formula, Excel performs operations in the following order: Brackets, Exponents, Division and Multiplication, Addition and Subtraction (left to right). Use this mnemonic device to remember them: (BEDMAS). |
| Concatenate Text           | Use the CONCAT function =CONCAT(text1, text2, ...) to join the text from multiple cells into a single cell. Use the arguments within the function to define the text you want to combine as well as any spaces or punctuation. |
| Payment Function           | Use the PMT function =PMT(rate, nper, pv, ...) to calculate a loan amount. Use the arguments within the function to define the loan rate, number of periods, and present value and Excel calculates the payment amount.        |
| Date Functions             | Date functions are used to add a specific date to a cell. Some common date functions in Excel include: Date =DATE(year, month, day), Today =TODAY(), Now =NOW()                                                                |
| Display Worksheet Formulas | Click the Formulas tab on the ribbon and then click the Show Formulas button. Click the Show Formulas button again to turn off the formula view.                                                                               |

## Macros

| Step                     | Description                                                                                                                                                                                                                            |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Enable the Developer Tab | Click the File tab and select Options. Select Customize Ribbon at the left. Check the Developer check box and click OK.                                                                                                                |
| Record a Macro           | Click the Developer tab on the ribbon and click the Record Macro button. Type a name and description then specify where to save it. Click OK. Complete the steps to be recorded. Click the Stop Recording button on the Developer tab. |
| Run a Macro              | Click the Developer tab on the ribbon and click the Macros button. Select the macro and click Run.                                                                                                                                     |
| Edit a Macro             | Click the Developer tab on the ribbon and click the Macros button. Select a macro and click the Edit button. Make the necessary changes to the Visual Basic code and click the Save button.                                            |
| Delete a Macro           | Click the Developer tab on the ribbon and click the Macros button. Select a macro and click the Delete button.                                                                                                                         |
| Macro Security           | Click the Developer tab on the ribbon and click the Macro Security button. Select a security level and click OK.                                                                                                                       |

## Advanced Formulas

| Function                 | Description                                                                                                                                                                                                                                                                                                                                         |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Nested Functions         | A nested function is when one function is tucked inside another function as one of its arguments, e.g.: =IF(D2>AVERAGE(B2:B10), 1, 0).                                                                                                                                                                                                              |
| IF                       | Performs a logical test to return one value for a true result, and another for a false result, e.g.: =IF(B2>69, "True", "False").                                                                                                                                                                                                                   |
| AND, OR, NOT             | Often used with IF to support multiple conditions. AND requires multiple conditions. OR accepts several different conditions. NOT returns the opposite of the condition. e.g.: =OR(B5="MN", B5="WI").                                                                                                                                               |
| SUMIF and AVERAGEIF      | Calculates cells that meet a condition. SUMIF finds the total. AVERAGEIF finds the average. e.g.: =SUMIF(C6:C10, "MN", D6:D10). Args: 1st(C6:C10) - Range of cells you want to apply criteria against, 2nd("MN") - Criteria used to determine what cells to sum or average, and 3rd(D6:D10) - calc-range to calculate, if different than the range. |
| VLOOKUP                  | Looks for and retrieves data from a specific column in a table. e.g.: =VLOOKUP(D2, A4:E10, 5). Args: 1st(D2) - Value to look for in the first column of the table, 2nd(A4:E10) - Table from which to retrieve a value, and 3rd(5) - Column number in the table from which to retrieve a value.                                                      |
| HLOOKUP                  | Looks for and retrieves data from a specific row in a table. e.g.: =HLOOKUP(B5, B2:I3, 3). Args: 1st(B5) - Value to look for in the first row of the table, 2nd(B3:I3) - Table from which to retrieve a value, and 3rd(3) - Row number in the table from which to retrieve a value.                                                                 |
| UPPER, LOWER, and PROPER | Changes how text is capitalized. e.g.: =UPPER(B4), text to change case or to capitalize.                                                                                                                                                                                                                                                            |
| LEFT and RIGHT           | Extracts a given number of characters from the left or right. e.g.: =LEFT(B5, 3), Args: 1st(B5) - Text from which to extract characters, 2nd(3) - Number of characters to extract from the left (or right) of the text.                                                                                                                             |
| MID                      | Extracts a given number of characters from the middle of text. e.g.: =MID("Sunday", 4, 3). Args: 1st("Sunday") - Text from which to extract the characters, 2nd(4) - Starting location of the first character to extract, and 3rd(3) - Number of characters to extract from the Starting location.                                                  |
| MATCH                    | Locates the position of a lookup value in a row or column. e.g.: =MATCH("Dog", B2:B10). Args: 1st("Dog") - Lookup value to match in the lookup range, 2nd(B2:B10) - Lookup range of Cells.                                                                                                                                                          |
| INDEX                    | Returns a value or the reference to a value from within a range. e.g.: =INDEX(A1:B5, 2, 2). Args: 1st(A1:B5) - Range of Cells, 2nd(2) - Row position, and 3rd(2) - Column position (optional).                                                                                                                                                      |

## Troubleshoot Formulas

| Formula Errors | Description                                            |
| :------------- | :----------------------------------------------------- |
| #####          | The column isn’t wide enough to display all cell data. |
| #NAME?         | The text in the formula isn’t recognized.              |
| #VALUE!        | There is an error with one or more formula arguments.  |
| #DIV0          | The formula is trying to divide a value by 0.          |
| #REF!          | The formula references a cell that no longer exists.   |
