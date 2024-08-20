import { Divider, Paper } from "@mui/material";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogContentText from "@mui/material/DialogContentText";
import DialogTitle from "@mui/material/DialogTitle";
import TextField from "@mui/material/TextField";
import { Box } from "@mui/system";
import React, { useState } from "react";
import { endpoint } from "./utils";

export const Form = (props) => {
  const [visible, setVisible] = useState(false);
  const [{ id, animal, description, age, price }, setPet] = useState({});

  const onSubmit = async () => {
    const body = JSON.stringify({
      animal: animal,
      description: description,
      age: age,
      price: price,
    });
    const headers = new Headers({ "Content-Type": "application/json" });
    if (props.action === "delete") {
      await fetch(`${endpoint}/${id}`, { method: "DELETE" });
    } else if (props.action === "add") {
      await fetch(endpoint, { method: "POST", headers: headers, body: body });
    } else if (props.action === "update") {
      await fetch(`${endpoint}/${id}`, {
        method: "PATCH",
        headers: headers,
        body: body,
      });
    }
    props.onSubmit();
    setVisible(!visible);
  };

  const onDialog = () => {
    setPet({ ...props.pet });
    setVisible(!visible);
  };

  const onChange = (event) => {
    setPet((prevState) => ({
      ...prevState,
      [event.target.name]: event.target.value,
    }));
  };

  const isValid = () =>
    animal !== undefined && animal !== "" &&
    description !== undefined && description !== "" &&
    age !== undefined && age !== "" && age > 0 &&
    price !== undefined && price !== "" && price >= 0;

  return (
    <>
      <Button
        color={props.color}
        onClick={onDialog}
      >
        {props.children}
      </Button>
      <Dialog
        open={visible}
        maxWidth="xs"
        PaperComponent={Paper}
        PaperProps={{ elevation: 9 }}
        onClose={onDialog}
      >
        <DialogTitle>{props.title}</DialogTitle>
        <Divider color="black" />
        <DialogContent>
          <DialogContentText>{props.desc}</DialogContentText>
          {props.action === "delete"
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
            )}
        </DialogContent>
        <DialogActions>
          <Button onClick={onDialog}>Cancel</Button>
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
};
