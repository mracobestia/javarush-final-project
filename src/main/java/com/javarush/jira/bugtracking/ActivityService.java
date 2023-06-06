package com.javarush.jira.bugtracking;

import com.javarush.jira.bugtracking.internal.model.Activity;
import com.javarush.jira.bugtracking.internal.model.Task;
import com.javarush.jira.bugtracking.internal.repository.ActivityRepository;
import com.javarush.jira.bugtracking.internal.repository.TaskRepository;
import com.javarush.jira.common.error.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class ActivityService {

    private final ActivityRepository repository;
    private final TaskRepository taskRepository;

    private final String STATUS_IN_PROGRESS = "in progress";
    private final String STATUS_READY = "ready";
    private final String STATUS_DONE = "done";

    public long getWorkOnTaskTime(Task task) {
        validateTask(task);

        List<Activity> startActivities = repository.getUpdatedByTask(task, STATUS_IN_PROGRESS);
        if(startActivities.isEmpty()) {
            return 0;
        }
        LocalDateTime start = startActivities.get(0).getUpdated();

        List<Activity> endActivities = repository.getUpdatedByTask(task, STATUS_READY);
        if(endActivities.isEmpty()) {
            return 0;
        }
        LocalDateTime end = endActivities.get(0).getUpdated();

        Duration duration = Duration.between(start, end);
        return duration.toHours();
    }

    public long getTestOnTaskTime(Task task) {
        validateTask(task);

        List<Activity> startActivities = repository.getUpdatedByTask(task, STATUS_READY);
        if(startActivities.isEmpty()) {
            return 0;
        }
        LocalDateTime start = startActivities.get(0).getUpdated();

        List<Activity> endActivities = repository.getUpdatedByTask(task, STATUS_DONE);
        if(endActivities.isEmpty()) {
            return 0;
        }
        LocalDateTime end = endActivities.get(0).getUpdated();

        Duration duration = Duration.between(start, end);
        return duration.toHours();
    }

    private void validateTask(Task task) {
        if (task == null) {
            throw new NotFoundException("Передан неверный параметр в метод getWorkOnTaskTime.");
        }

        Optional<Task> taskOptional = taskRepository.findById(task.getId());
        if (taskOptional.isEmpty()) {
            throw new NotFoundException("Указанной задачи не существует. Вычислить время выполнения невозможно.");
        }
    }
}
