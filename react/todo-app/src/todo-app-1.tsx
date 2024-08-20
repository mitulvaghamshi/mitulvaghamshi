import { React, react } from "../deps.ts";

const Item = (id = -1, value = ""): { id: number; value: string } => ({
  id,
  value,
});

const TodoApp1 = (props: { initialTodo: { id: number; value: string }[] }) => {
  const [todoList, updateList] = react.useState(new Map());
  const [todo, onSelect] = react.useState(Item());

  react.useEffect(() => {
    const tempList = new Map();
    props.initialTodo.forEach((todo: { id: number }) =>
      tempList.set(todo.id, todo)
    );
    updateList(tempList);
  }, [props.initialTodo]);

  const handleClick = (action: string, todo: { id: number; value: string }) => {
    const tempList = new Map(todoList);
    if (action === "SET") {
      tempList.set(todo.id, todo);
      updateList(tempList);
    } else if (action === "DELETE") {
      tempList.delete(todo.id);
      updateList(tempList);
    }
    onSelect(action === "EDIT" ? todo : Item());
  };

  const listItems: {
    key: string;
    index: number;
    todo: { id: number; value: string };
    isActive: boolean;
    onClick: (action: string, todo: { id: number; value: string }) => void;
  }[] = [];

  let index = 1;

  for (const key of todoList.keys()) {
    const item = todoList.get(key);
    listItems.push(
      <ListItem
        key={key}
        todo={item}
        index={index++}
        isActive={item.id === todo.id}
        onClick={handleClick}
      />,
    );
  }

  return (
    <div className="app1">
      <label className="title">iTodo App</label>
      <Form onSubmit={handleClick} todo={todo} />
      <div className="Todo-list">{listItems}</div>
    </div>
  );
};

const ListItem = (
  props: {
    key: string;
    index: number;
    todo: { id: number; value: string };
    isActive: boolean;
    onClick: (action: string, todo: { id: number; value: string }) => void;
  },
) => (
  <div>
    <li className="List-item">
      <label
        className={"Item-thumb" + (props.isActive ? " Active-item" : "")}
        onClick={props.onClick}
      >
        {props.isActive ? "↩" : props.index}
      </label>
      <input
        type="text"
        className="Item-content"
        readOnly
        value={props.todo.value}
      />
      <div className="Item-controls">
        <button
          className="Action-btn Edit"
          onClick={() => props.onClick("EDIT", props.todo)}
        >
          ✍🏻
        </button>
        <button
          className="Action-btn Delete"
          onClick={() => props.onClick("DELETE", props.todo)}
        >
          ✖
        </button>
      </div>
    </li>
  </div>
);

const Form = (
  props: {
    todo: { id: number; value: string };
    onSubmit: (action: string, todo: { id: number; value: string }) => void;
  },
) => {
  const [action, setAction] = react.useState("ADD");
  const [input, setInput] = react.useState("");
  const [id, setId] = react.useState(0);

  const handleClick = (event: { preventDefault: () => void }) => {
    event.preventDefault();
    if (input !== "") {
      let xId = id;
      if (action === "ADD") {
        setId(id + 1);
      } else {
        xId = props.todo.id;
      }
      props.onSubmit("SET", Item(xId, input));
      setInput("");
    }
  };

  react.useEffect(() => {
    setInput(props.todo.value);
    setAction(props.todo.value === "" ? "ADD" : "UPDATE");
  }, [props.todo]);

  return (
    <form className="Input-form">
      <input
        className="Input-element"
        type="search"
        autoFocus
        placeholder="What to do...?"
        value={input}
        onChange={(e: { target: { value: string } }) =>
          setInput(e.target.value)}
      />
      <div className="Item-controls">
        <button className="Action-btn Add" onClick={handleClick}>
          {action}
        </button>
      </div>
    </form>
  );
};

export default function App1() {
  return (
    <TodoApp1
      initialTodo={[
        Item(1001, "Submit ASP.NET assignment tonight before it due."),
        Item(1002, "Watch recorded lecture videos."),
        Item(1003, "Get milk from walmart."),
        Item(1004, "Start Data Structure after dinner."),
        Item(1005, "Delete node_modules after submitting assignment."),
      ]}
    />
  );
}
