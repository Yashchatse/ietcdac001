// C++ Program to implement a simple To-Do List
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// Task class to store task details
class Task {
private:
    string name, description, dueDate; // Task details
    bool completed; // Task completion status

public:
    // Constructor to initialize a task
    Task(const string& name, const string& description, const string& dueDate)
        : name(name), description(description), dueDate(dueDate), completed(false) {}

    // Getters
    string getName() const { return name; }
    string getDescription() const { return description; }
    string getDueDate() const { return dueDate; }
    bool isCompleted() const { return completed; }

    // Setters
    void setName(const string& newName) { name = newName; }
    void setDescription(const string& newDescription) { description = newDescription; }
    void setDueDate(const string& newDueDate) { dueDate = newDueDate; }
    void markCompleted() { completed = true; }

    // Display task details
    void displayTask() const {
        cout << name << " (" << (completed ? "Completed" : "Pending")
             << ") - Due: " << dueDate << "\n   Description: " << description << endl;
    }
};

// ToDoList class to manage tasks
class ToDoList {
private:
    vector<Task> tasks; // List of tasks

    // Helper function to display all tasks
    void listTasks() {
        if (tasks.empty()) {
            cout << "No tasks available!" << endl;
            return;
        }
        for (size_t i = 0; i < tasks.size(); ++i) {
            cout << i + 1 << ". " << tasks[i].getName() << endl;
        }
    }

public:
    // Display menu options
    void displayMenu() {
        cout << "\n---------- To-Do List Menu -----------\n"
             << "1. Add Task\n2. Delete Task\n3. Display Tasks\n"
             << "4. Mark Task as Completed\n5. Edit Task\n6. Exit\n"
             << "-----------------------------------------\n";
    }

    // Add a new task
    void addTask() {
        string name, description, dueDate;
        cin.ignore(); // Clear buffer
        cout << "Enter task name: "; getline(cin, name);
        cout << "Enter task description: "; getline(cin, description);
        cout << "Enter task due date (YYYY-MM-DD): "; getline(cin, dueDate);
       tasks.push_back(Task(name, description, dueDate));
        cout << "Task added successfully!\n";
    }

    // Delete a task
    void deleteTask() {
        if (tasks.empty()) {
            cout << "No tasks to delete!\n";
            return;
        }
        listTasks();
        int taskNumber;
        cout << "Enter the task number to delete: "; cin >> taskNumber;
        if (taskNumber > 0 && taskNumber <= tasks.size()) {
            tasks.erase(tasks.begin() + taskNumber - 1);
            cout << "Task deleted successfully!\n";
        } else {
            cout << "Invalid task number!\n";
        }
    }

    // Display all tasks
    void displayTasks() {
        if (tasks.empty()) {
            cout << "No tasks to display!\n";
            return;
        }
        for (size_t i = 0; i < tasks.size(); ++i) {
            cout << i + 1 << ". ";
            tasks[i].displayTask();
        }
    }

    // Mark a task as completed
    void markTaskCompleted() {
        if (tasks.empty()) {
            cout << "No tasks to mark as completed!\n";
            return;
        }
        listTasks();
        int taskNumber;
        cout << "Enter task number to mark as completed: "; cin >> taskNumber;
        if (taskNumber > 0 && taskNumber <= tasks.size()) {
            tasks[taskNumber - 1].markCompleted();
            cout << "Task marked as completed!\n";
        } else {
            cout << "Invalid task number!\n";
        }
    }

    // Edit a task
    void editTask() {
        if (tasks.empty()) {
            cout << "No tasks to edit!\n";
            return;
        }
        listTasks();
        int taskNumber;
        cout << "Enter task number to edit: "; cin >> taskNumber;
        if (taskNumber > 0 && taskNumber <= tasks.size()) {
            cin.ignore();
            Task& task = tasks[taskNumber - 1];
            string name, description, dueDate;
            cout << "New task name (current: " << task.getName() << "): "; getline(cin, name);
            cout << "New task description (current: " << task.getDescription() << "): "; getline(cin, description);
            cout << "New task due date (current: " << task.getDueDate() << "): "; getline(cin, dueDate);
            task.setName(name);
            task.setDescription(description);
            task.setDueDate(dueDate);
            cout << "Task updated successfully!\n";
        } else {
            cout << "Invalid task number!\n";
        }
    }

    // Run the To-Do List application
    void run() {
        int choice;
        do {
            displayMenu();
            cout << "Enter your choice: "; cin >> choice;
            switch (choice) {
                case 1: addTask(); break;
                case 2: deleteTask(); break;
                case 3: displayTasks(); break;
                case 4: markTaskCompleted(); break;
                case 5: editTask(); break;
                case 6: cout << "Exiting program. Bye!\n"; break;
                default: cout << "Invalid choice. Please try again!\n";
            }
        } while (choice != 6);
    }
};

// Main function to execute the program
int main() {
    ToDoList toDoList;
    toDoList.run();
    return 0;
}
