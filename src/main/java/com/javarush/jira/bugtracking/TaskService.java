package com.javarush.jira.bugtracking;

import com.javarush.jira.bugtracking.internal.mapper.TaskMapper;
import com.javarush.jira.bugtracking.internal.model.Task;
import com.javarush.jira.bugtracking.internal.repository.TaskRepository;
import com.javarush.jira.bugtracking.to.TaskTo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TaskService extends BugtrackingService<Task, TaskTo, TaskRepository> {

    public TaskService(TaskRepository repository, TaskMapper mapper) {
        super(repository, mapper);
    }

    public List<TaskTo> getAll() {
        return mapper.toToList(repository.getAll());
    }

    public Task getById(Long taskId) {
        Optional<Task> taskOptional = repository.findById(taskId);
        return taskOptional.orElse(null);
    }

    public Task saveTask(Task task) {
        return repository.save(task);
    }

}
