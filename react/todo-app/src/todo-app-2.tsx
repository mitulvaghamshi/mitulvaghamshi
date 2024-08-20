import { React, react } from "../deps.ts";

const TodoApp2 = (props: { defaults: string[] }) => {
  const [input, setInput] = react.useState("");
  const [todo, setTodo] = react.useState(Item());
  const [list, setList] = react.useState(new Map());

  react.useEffect(() => setInput(todo.value), [todo]);

  react.useEffect(() => {
    const temp = new Map();
    props.defaults.forEach((value: string) => {
      const id: number = getId();
      temp.set(id, Item(id, value));
    });
    setList(temp);
  }, [props.defaults]);

  const deleteAll = (event: { preventDefault: () => void }) => {
    event.preventDefault();
    setList(new Map());
  };

  const onDelete = (id: number) => {
    const temp = new Map(list);
    temp.delete(id);
    setList(temp);
  };

  const onSave = (event: { preventDefault: () => void }) => {
    event.preventDefault();
    if (input !== "") {
      const temp = new Map(list);
      const id = todo && todo.value !== "" ? todo.id : getId();
      temp.set(id, Item(id, input));
      setList(temp);
      setTodo(Item());
    }
  };

  const items: any[] = [];
  let index = 0;
  for (const key of list.keys()) {
    const item = list.get(key);
    items.push(
      <li key={key}>
        <label className="btn">{++index}</label>
        <label className="content">{item.value}</label>
        <div className="inline">
          <button className="btn" onClick={() => setTodo(item)}>Edit</button>
          <button className="btn" onClick={() => onDelete(key)}>Delete</button>
        </div>
      </li>,
    );
  }

  return (
    <div className="app2">
      <label className="title">xTodo App</label>
      <form>
        <input
          type="text"
          value={input}
          className="input"
          onChange={(e: { target: { value: string } }) =>
            setInput(e.target.value)}
        />
        <button className="inline btn" onClick={onSave}>
          {todo.value === "" ? "ADD" : "SAVE"}
        </button>
        <button className="inline btn" onClick={deleteAll}>
          Delete All
        </button>
      </form>
      <div className="list">{items}</div>
    </div>
  );
};

const Item = (id = -1, value = ""): { id: number; value: string } => ({
  id,
  value,
});

let count = 0;
const getId = () => count++;

export default function App2() {
  return (
    <TodoApp2
      defaults={[
        "Pay Credit Card Bill",
        "Goto LCBO this evening",
        "Comlete Netflix series",
        "Order Pizza from Dominos",
        "Continue JavaScript Youtube series",
      ]}
    />
  );
}
