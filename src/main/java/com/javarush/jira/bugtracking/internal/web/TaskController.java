package com.javarush.jira.bugtracking.internal.web;

import com.javarush.jira.bugtracking.TaskService;
import com.javarush.jira.bugtracking.internal.model.Task;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashSet;


@Slf4j
@RestController
@RequestMapping("/api/tasks")
public class TaskController {

    private final TaskService taskService;

    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @PostMapping("/{taskId}/tags")
    public ResponseEntity<Task> addTagToTask(@PathVariable("taskId") Long taskId, @RequestBody String tag) {
        Task task = taskService.getById(taskId);
        if (task == null) {
            return ResponseEntity.notFound().build();
        }
        task.setTags(new HashSet<>(Arrays.asList(tag)));
        return ResponseEntity.ok(taskService.saveTask(task));
    }
}
