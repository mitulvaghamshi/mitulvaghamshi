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
import { useEffect, useState } from "react";
import { PetEditForm } from "./PetEditForm";
import { SearchAppBar } from "./SerachAppBar";
import { API_HOST } from "./utils";

export function App() {
  const [items, setItems] = useState([]);
  const [isLoading, setLoading] = useState(true);
  const [reload, setReload] = useState(0);

  // Pagination controller
  const [activePage, setActivePage] = useState(0);
  const [itemsPerPage, setItemsPerPage] = useState(3);

  async function onSearch({ target: { value } }) {
    if (value) {
      console.debug(`[LOG]: Searching for pet with term: '${value}'.`);
      const res = await fetch(`${API_HOST}/search?term=${value}`);
      const list = await res.json();
      if (list) setItems(list);
    } else {
      console.debug(`[LOG]: Requesting page refresh!`);
      setLoading(true);
      setReload(reload + 1);
    }
    setActivePage(0);
  }

  useEffect(function () {
    console.debug("[LOG]: useEffect called...!");
    (async function () {
      console.debug("[LOG]: Fetching all items!");
      const res = await fetch(`${API_HOST}/pets`);
      const list = await res.json();
      if (list) setItems(list);
      setLoading(false);
    })();
  }, [reload]);

  return (
    <Paper elevation={0}>
      <SearchAppBar onInput={onSearch} />
      {isLoading ? <LinearProgress /> : (
        <>
          <Box sx={{ my: 3, ml: 2 }}>
            <PetEditForm
              action="add"
              title="Add new pet"
              desc="Fill details and click add to save, or click cancel to abort."
              onSubmit={function () {
                console.debug("[LOG]: Form submission to add new pet.");
                setLoading(true);
                setReload(reload + 1);
              }}
            >
              <Button variant="contained">
                <Add sx={{ mr: 1 }} />Add new pet
              </Button>
            </PetEditForm>
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
                  {items.length === 0
                    ? (
                      <TableRow>
                        <TableCell>No result found!</TableCell>
                      </TableRow>
                    )
                    : items.slice(
                      activePage * itemsPerPage,
                      activePage * itemsPerPage + itemsPerPage,
                    ).map(function (pet) {
                      return (
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
                            <PetEditForm
                              title={`Edit: ${pet.animal}`}
                              pet={pet}
                              action="update"
                              color="success"
                              desc="Update details and click submit to save, or click cancel to abort."
                              onSubmit={function () {
                                console.debug(
                                  `[LOG]: Form submission to update pet: ${pet.id}.`,
                                );
                                setLoading(true);
                                setReload(reload + 1);
                              }}
                            >
                              <Edit />
                            </PetEditForm>
                          </TableCell>
                          <TableCell align="center">
                            <PetEditForm
                              title={`Deleting ${pet.animal}`}
                              pet={pet}
                              action="delete"
                              color="error"
                              desc="This action is permanent and can not be undone, are you sure want delete?"
                              onSubmit={function () {
                                console.debug(
                                  `[LOG]: Form submission to delete pet: ${pet.id}.`,
                                );
                                setLoading(true);
                                setReload(reload + 1);
                              }}
                            >
                              <DeleteIcon />
                            </PetEditForm>
                          </TableCell>
                        </TableRow>
                      );
                    })}
                </TableBody>
              </Table>
            </TableContainer>
            {/* https://mui.com/components/tables/#custom-pagination-options */}
            <TablePagination
              page={activePage}
              component="div"
              count={items.length}
              rowsPerPage={itemsPerPage}
              onPageChange={function (_, page) {
                console.debug(
                  `[LOG]: Changing active page from ${activePage} to: ${page}.`,
                );
                setActivePage(page);
              }}
              rowsPerPageOptions={[3, 5, { value: items.length, label: "All" }]}
              onRowsPerPageChange={function ({ target: { value } }) {
                console.debug(
                  `[LOG]: Changing items per page from ${itemsPerPage} to: ${value}.`,
                );
                setItemsPerPage(value);
                console.debug(
                  `[LOG]: Changing active page from ${activePage} to: ${0}.`,
                );
                setActivePage(0);
              }}
            />
          </Paper>
        </>
      )}
    </Paper>
  );
}
