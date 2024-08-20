import Add from "@mui/icons-material/Add";
import DeleteIcon from "@mui/icons-material/Delete";
import Edit from "@mui/icons-material/Edit";
import {
  Button,
  LinearProgress,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TablePagination,
  TableRow,
} from "@mui/material";
import { Box } from "@mui/system";
import React, { useLayoutEffect, useState } from "react";
import { SearchAppBar } from "./appbar";
import { Form } from "./form";
import { endpoint } from "./utils";

export const App = () => {
  const [pets, setPets] = useState([]);
  const [reload, setReload] = useState(true);

  // Pagination controllers
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(3);

  const onSearch = async (event) => {
    if (event.target.value === "") {
      setReload(true);
    } else {
      const response = await fetch(
        `${endpoint}/search?term=${event.target.value}`,
      );
      const result = await response.json();
      setPets(result);
    }
    setPage(0);
  };

  useLayoutEffect(() => {
    (async () => {
      const responce = await fetch(`${endpoint}/pets`);
      const result = await responce.json();
      setPets(result);
      setReload(false);
    })();
  }, [reload]);

  return (
    <Paper elevation={0}>
      <SearchAppBar onInput={onSearch} />
      {reload ? <LinearProgress /> : (
        <>
          <Box sx={{ my: 3, ml: 2 }}>
            <Form
              action="add"
              title="Add new pet"
              desc="Fill details and click add to save, or click cancel to abort."
              onSubmit={() => setReload(true)}
            >
              <Button variant="contained">
                <Add sx={{ mr: 1 }} />Add new pet
              </Button>
            </Form>
          </Box>
          <Paper elevation={9} sx={{ m: 3 }}>
            <TableContainer sx={{ maxHeight: 350 }}>
              <Table stickyHeader area-label="Data Table">
                <TableHead>
                  <TableRow>
                    <TableCell style={{ fontWeight: "bold" }}>
                      Animal
                    </TableCell>
                    <TableCell style={{ fontWeight: "bold" }}>
                      Description
                    </TableCell>
                    <TableCell style={{ fontWeight: "bold" }} align="right">
                      Age
                    </TableCell>
                    <TableCell style={{ fontWeight: "bold" }} align="right">
                      Price
                    </TableCell>
                    <TableCell />
                    <TableCell style={{ fontWeight: "bold" }} align="center">
                      Edit
                    </TableCell>
                    <TableCell style={{ fontWeight: "bold" }} align="center">
                      Delete
                    </TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {pets.length === 0
                    ? (
                      <TableRow>
                        <TableCell>No result found!</TableCell>
                      </TableRow>
                    )
                    : pets.slice(
                      page * rowsPerPage,
                      page * rowsPerPage + rowsPerPage,
                    )
                      .map((pet) => (
                        <TableRow key={pet.id}>
                          <TableCell component="th" scope="row">
                            {pet.animal}
                          </TableCell>
                          <TableCell>
                            {pet.description}
                          </TableCell>
                          <TableCell align="right">
                            {pet.age} yr
                          </TableCell>
                          <TableCell align="right">
                            ${pet.price}
                          </TableCell>
                          <TableCell />
                          <TableCell align="center">
                            <Form
                              action="update"
                              pet={pet}
                              color="success"
                              onSubmit={() => setReload(true)}
                              title={`Edit: ${pet.animal}`}
                              desc="Update details and click submit to save, or click cancel to abort."
                            >
                              <Edit />
                            </Form>
                          </TableCell>
                          <TableCell align="center">
                            <Form
                              action="delete"
                              pet={pet}
                              color="error"
                              onSubmit={() => setReload(true)}
                              title={`Deleting ${pet.animal}`}
                              desc="This action is permanent and can not be undone, are you sure want delete?"
                            >
                              <DeleteIcon />
                            </Form>
                          </TableCell>
                        </TableRow>
                      ))}
                </TableBody>
              </Table>
            </TableContainer>
            {/* https://mui.com/components/tables/#custom-pagination-options */}
            <TablePagination
              page={page}
              component="div"
              count={pets.length}
              rowsPerPage={rowsPerPage}
              onPageChange={(e, page) => setPage(page)}
              rowsPerPageOptions={[3, 5, { value: pets.length, label: "All" }]}
              onRowsPerPageChange={(e) => {
                setRowsPerPage(e.target.value);
                setPage(0);
              }}
            />
          </Paper>
        </>
      )}
    </Paper>
  );
};
