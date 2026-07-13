# src/app.py

from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from src.database import SessionLocal, engine
from src.models import Base, Task
from src.schemas import TaskCreate, TaskResponse

from src.settings import settings
from logger import get_logger


# ==================================================
# Logger
# ==================================================

logger = get_logger(__name__)


# ==================================================
# Database Initialization
# ==================================================

logger.info("Creating database tables...")


logger.info("Database initialization complete")


# ==================================================
# FastAPI App
# ==================================================

app = FastAPI(
    title=settings.APP_NAME,
    version="1.0.0"
)


# ==================================================
# CORS
# ==================================================

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        settings.CORS_ORIGINS
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

logger.info("CORS middleware configured")


# ==================================================
# Dependency
# ==================================================

def get_db():
    db = SessionLocal()

    try:
        yield db

    finally:
        db.close()


# ==================================================
# Startup Event
# ==================================================

@app.on_event("startup")
async def startup_event():
    logger.info(
        f"{settings.APP_NAME} started "
        f"in {settings.ENVIRONMENT} mode"
    )


# ==================================================
# Health Check
# ==================================================

@app.get("/health")
def health():

    logger.info("Health endpoint accessed")

    return {
        "status": "healthy",
        "service": settings.APP_NAME,
        "environment": settings.ENVIRONMENT
    }


# ==================================================
# Create Task
# ==================================================

@app.post("/tasks", response_model=TaskResponse)
def create_task(
    task: TaskCreate,
    db: Session = Depends(get_db)
):
    logger.info(
        f"Creating task with title='{task.title}'"
    )

    new_task = Task(
        title=task.title,
        description=task.description
    )
    

    db.add(new_task)
    db.commit()
    db.refresh(new_task)

    logger.info(
        f"Task created successfully id={new_task.id}"
    )

    return new_task


# ==================================================
# List Tasks
# ==================================================

@app.get("/tasks", response_model=list[TaskResponse])
def list_tasks(
    db: Session = Depends(get_db)
):
    tasks = db.query(Task).all()

    logger.info(
        f"Fetched {len(tasks)} tasks"
    )

    return tasks


# ==================================================
# Delete Task
# ==================================================

@app.delete("/tasks/{task_id}")
def delete_task(
    task_id: int,
    db: Session = Depends(get_db)
):
    logger.warning(
        f"Delete request received for task_id={task_id}"
    )

    task = db.query(Task).filter(
        Task.id == task_id
    ).first()

    if not task:

        logger.error(
            f"Task not found task_id={task_id}"
        )

        raise HTTPException(
            status_code=404,
            detail="Task not found"
        )

    db.delete(task)
    db.commit()

    logger.warning(
        f"Task deleted successfully task_id={task_id}"
    )

    return {
        "message": "Task deleted"
    }