// This function will respond to different user actions and allows to perform required database operations using Ajax
// execute script when dom is ready
window.onload = async () => {
  // retrieve html elements
  const listElement = document.getElementById("item-list"); // unorder list container
  const quantityInput = document.getElementById("quantity"); // item quantity
  const addButton = document.getElementById("add-btn"); // add new item button
  const itemInput = document.getElementById("item"); // item name
  listElement.innerHTML = ""; // clear list on every request to this method

  // add new item to the database
  addButton.addEventListener("click", async (_) => {
    // check if user entered an item name
    if (itemInput.value === null || itemInput.value === "") {
      itemInput.focus();
    } else {
      // request script with parameters to add new item
      const url =
        `php/add-item.php?item=${itemInput.value}&quantity=${quantityInput.value}`;
      await fetch(url, { credentials: "include" }).then((_) => start());
      quantityInput.value = "1"; // reset quantity textbox
      itemInput.value = ""; // clear item name textbox
    }
  });

  // request a script to fetch all items from the database
  const result = await fetch("php/get-list.php", { credentials: "include" });
  // convert server response to json object
  const response = result.json();

  // if response is not 999 (999 = no record found in database)
  if (response != "999") {
    // iterate over an array of objects
    response.forEach((jsonObject) => {
      // create a list-item html element
      const listItem = document.createElement("li");
      listItem.classList = "list-item"; // assign css class

      // create an html checkbox input element
      const checkbox = document.createElement("input");
      checkbox.type = "checkbox"; // set input type to checkbox
      checkbox.classList = "quantity-text checkbox"; // assign css class
      checkbox.addEventListener("click", (_) => { // add click listener
        // on checkbox state changed, update database value and reload list items
        const url = `php/check-item.php?id=${jsonObject["id"]}&done=${
          jsonObject["isdone"]
        }`;
        fetch(url, { credentials: "include" }).then((_) => start());
      });

      // create a text input element for item name
      const item = document.createElement("input");
      item.type = "text"; // set type to plain text
      item.readOnly = true; // disable editing
      item.classList = "item-text"; // assign css class
      item.value = jsonObject["item"]; // set item name from json object

      // if the task or item purchase is completed
      if (jsonObject["isdone"] == "1") {
        checkbox.checked = true; // make checkbox checked
        item.style.textDecoration = "line-through"; // draw line over item name
      }

      // create an element for item quantity
      const quantity = document.createElement("input");
      quantity.type = "number"; // set input type to number
      quantity.readOnly = true; // disable editing
      quantity.classList = "quantity-text"; // assign css class
      quantity.value = jsonObject["quantity"]; // set item quantity from json object

      // create html button to delete an item
      const deleteBtn = document.createElement("input");
      deleteBtn.type = "button"; // set type to button
      deleteBtn.value = "❌"; // set delete like icon
      deleteBtn.classList = "add-button"; // assign css class
      deleteBtn.addEventListener("click", (_) => { // add click listener to delete
        // request a script with item id to delete from database then reload list items
        const url = `php/delete-item.php?id=${jsonObject["id"]}`;
        fetch(url, { credentials: "include" }).then((_) => start());
      });

      // create a button to edit an item from list
      const editBtn = document.createElement("input");
      editBtn.type = "button"; // set type to button
      editBtn.value = "🖋"; // set edit like icon
      editBtn.style.color = "#ff0000"; // set color to red
      editBtn.classList = "add-button"; // assign css class
      editBtn.addEventListener("click", (_) => { // add click listener
        //
        item.readOnly = false; // make item name editable
        quantity.readOnly = false; // make item quantity ediable
        checkbox.checked = false; // clear checkbox (if checked)
        item.style.textDecoration = "none"; // remove overline (if any)
        editBtn.style.display = "none"; // hide edit-button
        doneBtn.style.display = "inline"; // show save-button
      });

      // create item save button (if edited)
      const doneBtn = document.createElement("input");
      doneBtn.type = "button"; // set type to button
      doneBtn.value = "✔"; // set done icon
      doneBtn.style.color = "#00ff00"; // set color to green
      doneBtn.style.display = "none"; // initially hide this button
      doneBtn.classList = "add-button"; // assign css class
      doneBtn.addEventListener("click", async (_) => { // add click-listener
        //
        const tItem = item.value; // get edited value of item namefrom textbox
        const tQuantity = parseInt(quantity.value); // get new quantity (only integers)
        // check if quantity is at least 1
        if (tQuantity > 0) {
          // check if item name is not empty
          if (tItem !== "") {
            doneBtn.style.display = "none"; // hide save-button
            editBtn.style.display = "inline"; // show edit-button
            // request script with new data and item id to update database record then reload list items
            const url = `php/edit-item.php?id=${
              jsonObject["id"]
            }&item=${tItem}&quantity=${tQuantity}`;
            await fetch(url, { credentials: "include" }).then((_) => start());
          } else {
            // focus item name textbox if value is empty
            item.focus();
          }
        } else {
          // focus item quantity textbox if value is less then 1
          quantity.focus();
        }
      });

      // add all elements to the list-item
      listItem.appendChild(checkbox); // add done-checkbox
      listItem.appendChild(item); // add name-input
      listItem.appendChild(quantity); // add quantity-input
      listItem.appendChild(editBtn); // add edit-button
      listItem.appendChild(doneBtn); // add save-button
      listItem.appendChild(deleteBtn); // add delete-button

      // add list item to unordered list element
      listElement.appendChild(listItem);
    });
  }
};
