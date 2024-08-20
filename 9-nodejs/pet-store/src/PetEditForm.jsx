import { Divider } from "@mui/material";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogContentText from "@mui/material/DialogContentText";
import DialogTitle from "@mui/material/DialogTitle";
import TextField from "@mui/material/TextField";
import { Box } from "@mui/system";
import { useState } from "react";
import { API_HOST, JsonHeader } from "./utils";

export function PetEditForm(props) {
  const [showForm, setShowForm] = useState(false);
  const [{ id, animal, description, age, price }, setPet] = useState({});

  async function onSubmit() {
    console.debug("[LOG]: Form submit clicked!");
    const body = JSON.stringify({
      animal: animal,
      description: description,
      age: age,
      price: price,
    });
    if (props.action === "add") {
      console.debug("[LOG]: Making POST api call to add new pet!");
      await fetch(API_HOST, {
        method: "POST",
        headers: JsonHeader,
        body: body,
      });
    } else if (props.action === "update") {
      console.debug("[LOG]: Making PATCH api call to update pet!");
      await fetch(`${API_HOST}/${id}`, {
        method: "PATCH",
        headers: JsonHeader,
        body: body,
      });
    } else if (props.action === "delete") {
      console.debug("[LOG]: Making DELETE api call to delete pet!");
      await fetch(`${API_HOST}/${id}`, {
        method: "DELETE",
        headers: JsonHeader,
      });
    }
    props.onSubmit();
    console.debug("[LOG]: Requesting to hide the form!");
    setShowForm(!showForm);
  }

  function onDialog() {
    console.debug("[LOG]: Copying parameter pet values to form fields!");
    setPet({ ...props.pet });
    console.debug("[LOG]: Requesting to show the form!");
    setShowForm(!showForm);
  }

  function onChange(event) {
    console.debug("[LOG]: Copying updated form values back!");
    const { target: { name, value } } = event;
    setPet(function (prevState) {
      return ({
        ...prevState,
        [name]: value,
      });
    });
  }

  function isValid() {
    return animal && description && age && age > 0 && price && price >= 0;
  }

  return (
    <>
      <Button
        color={props.color}
        onClick={onDialog}
      >
        {props.children}
      </Button>
      <Dialog
        maxWidth="xs"
        open={showForm}
        onClose={onDialog}
      >
        <DialogTitle>{props.title}</DialogTitle>
        <Divider color="black" />
        <DialogContent>
          <DialogContentText>{props.desc}</DialogContentText>
          {
            props.action === "delete"
              ? null
              : (
                <Box component="form" autoComplete="off" aria-required>
                  <TextField
                    autoFocus
                    fullWidth
                    id="name"
                    type="text"
                    name="animal"
                    margin="dense"
                    label="Pet name"
                    variant="outlined"
                    onInput={onChange}
                    defaultValue={animal}
                  />
                  <TextField
                    fullWidth
                    id="desc"
                    type="text"
                    name="description"
                    margin="dense"
                    label="Description"
                    variant="outlined"
                    onInput={onChange}
                    defaultValue={description}
                  />
                  <Box sx={{ display: "flex", justifyContent: "space-between" }}>
                    <TextField
                      id="age"
                      type="number"
                      name="age"
                      margin="dense"
                      label="Age"
                      variant="outlined"
                      onInput={onChange}
                      defaultValue={age}
                    />
                    <TextField
                      id="price"
                      type="number"
                      name="price"
                      margin="dense"
                      label="Price ($)"
                      variant="outlined"
                      onInput={onChange}
                      defaultValue={price}
                    />
                  </Box>
                </Box>
              )
          }
        </DialogContent>
        <DialogActions>
          <Button
            onClick={onDialog}
          >
            Cancel
          </Button>
          <Button
            variant="contained"
            disabled={!isValid()}
            color={props.color}
            onClick={onSubmit}
          >
            {props.action}
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
}
