import { useEffect, useState } from "react";
import { APP_CONFIG } from "./config/app";
import { getTasks, createTask, deleteTask, checkHealth } from "./api";

function App() {
  const [tasks, setTasks] = useState([]);

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");

  const [health, setHealth] = useState(null);

  async function loadTasks() {
    try {
      const data = await getTasks();
      setTasks(data);
    } catch (error) {
      console.error(error);
    }
  }

  async function handleCreate() {
    if (!title.trim()) return;

    try {
      await createTask(title, description);

      setTitle("");
      setDescription("");

      await loadTasks();
    } catch (error) {
      console.error(error);
    }
  }

  async function handleDelete(id) {
    try {
      await deleteTask(id);
      await loadTasks();
    } catch (error) {
      console.error(error);
    }
  }

  useEffect(() => {
    const initialize = async () => {
      try {
        const [tasksData, healthData] = await Promise.all([
          getTasks(),
          checkHealth(),
        ]);

        setTasks(tasksData);
        setHealth(healthData);
      } catch (error) {
        console.error(error);

        setHealth({
          status: "backend unavailable",
        });
      }
    };

    initialize();
  }, []);

  return (
    <>
      <div
        style={{
          padding: "2rem",
          maxWidth: "700px",
          margin: "0 auto",
        }}
      >
        <h1>Toy Deployment App</h1>

        <h3>Backend Status: {health?.status || "checking..."}</h3>

        <hr />

        <div
          style={{
            display: "flex",
            flexDirection: "column",
            gap: "10px",
            marginBottom: "20px",
          }}
        >
          <input
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Task title"
          />

          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Task description"
            rows={4}
          />

          <button onClick={handleCreate}>Add Task</button>
        </div>

        <hr />

        <h2>Tasks</h2>

        {tasks.length === 0 ? (
          <p>No tasks found.</p>
        ) : (
          <ul
            style={{
              listStyle: "none",
              padding: 0,
            }}
          >
            {tasks.map((task) => (
              <li
                key={task.id}
                style={{
                  border: "1px solid #ddd",
                  padding: "12px",
                  marginBottom: "12px",
                  borderRadius: "8px",
                }}
              >
                <h3>{task.title}</h3>

                {task.description && <p>{task.description}</p>}

                <button onClick={() => handleDelete(task.id)}>Delete</button>
              </li>
            ))}
          </ul>
        )}
      </div>

      <div className="fixed bottom-2 right-3 text-xs text-gray-400 select-none">
        {APP_CONFIG.VERSION}
      </div>
    </>
  );
}

export default App;
