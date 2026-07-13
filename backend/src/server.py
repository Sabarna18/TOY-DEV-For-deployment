from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from src.database import SessionLocal
from src.models import Task
from src.schemas import TaskCreate, TaskResponse

from logger import get_logger


logger = get_logger(__name__)

router = APIRouter(
    prefix="/api/v1",
    tags=["API"]
)


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
# Health Check
# ==================================================

@router.get("/health")
def health():

    logger.info("Health endpoint accessed")

    return {
        "status": "healthy"
    }


# ==================================================
# Create Task
# ==================================================

@router.post("/tasks", response_model=TaskResponse)
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

@router.get("/tasks", response_model=list[TaskResponse])
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

@router.delete("/tasks/{task_id}")
def delete_task(
    task_id: int,
    db: Session = Depends(get_db)
):

    logger.warning(
        f"Delete request received for task_id={task_id}"
    )

    task = (
        db.query(Task)
        .filter(Task.id == task_id)
        .first()
    )

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