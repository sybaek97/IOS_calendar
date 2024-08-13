import EventKit

class CalendarManager {
    let eventStore = EKEventStore()

    func requestRemindersAccess() {
        if #available(macOS 17, *) {
            // macOS 17 이상
            eventStore.requestFullAccessToReminders { (granted, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error requesting reminders access: \(error.localizedDescription)")
                        return
                    }

                    if granted {
                        print("Access granted, now fetching reminders.")
                        self.fetchReminders()
                    } else {
                        print("Reminders access denied. Please enable access in System Preferences.")
                    }
                }
            }
        } else {
            // macOS 17 이하
            eventStore.requestAccess(to: .reminder) { (granted, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error requesting reminders access: \(error.localizedDescription)")
                        return
                    }

                    if granted {
                        print("Access granted, now fetching reminders.")
                        self.fetchReminders()
                    } else {
                        print("Reminders access denied. Please enable access in System Preferences.")
                    }
                }
            }
        }
    }

    func fetchReminders() {
        let predicate = eventStore.predicateForReminders(in: nil)
        
        eventStore.fetchReminders(matching: predicate) { reminders in
            print("fetchReminders completion block called")
            if let reminders = reminders {
                if reminders.isEmpty {
                    print("No reminders found.")
                } else {
                    for reminder in reminders {
                        print("Reminder Title: \(reminder.title ?? "No Title")")
                        print("Completion Date: \(String(describing: reminder.completionDate))")
                        print("Due Date: \(String(describing: reminder.dueDateComponents?.date))")
                        print("-------------------------------")
                    }
                }
            } else {
                print("No reminders found or an error occurred.")
            }
        }
    }
}
