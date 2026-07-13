const API_BASE = import.meta.env.VITE_API_URL;

// ==========================================
// Get All Tasks
// ==========================================

export async function getTasks() {
  const response = await fetch(`${API_BASE}/tasks`);

  if (!response.ok) {
    throw new Error("Failed to fetch tasks");
  }

  return response.json();
}

// ==========================================
// Create Task
// ==========================================

export async function createTask(title, description = "") {
  const response = await fetch(`${API_BASE}/tasks`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      title,
      description,
    }),
  });

  if (!response.ok) {
    throw new Error("Failed to create task");
  }

  return response.json();
}

// ==========================================
// Delete Task
// ==========================================

export async function deleteTask(id) {
  const response = await fetch(`${API_BASE}/tasks/${id}`, {
    method: "DELETE",
  });

  if (!response.ok) {
    throw new Error("Failed to delete task");
  }

  return response.json();
}

// ==========================================
// Health Check
// ==========================================

export async function checkHealth() {
  const response = await fetch(`${API_BASE}/health`);

  if (!response.ok) {
    throw new Error("Backend unavailable");
  }

  return response.json();
}
