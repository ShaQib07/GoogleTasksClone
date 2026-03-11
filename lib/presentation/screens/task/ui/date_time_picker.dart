import 'package:flutter/material.dart';
import 'package:google_tasks_clone/core/extensions/date_time.dart';
import 'package:google_tasks_clone/core/extensions/tome_of_day.dart';
import 'package:google_tasks_clone/presentation/screens/task/ui/widgets/dismissible_chip.dart';
import 'package:google_tasks_clone/resources/app_strings.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key, this.selectedDateTime});

  final DateTime? selectedDateTime;

  @override
  State<StatefulWidget> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDate = widget.selectedDateTime ?? DateTime.now();
  late TimeOfDay? _selectedTime = widget.selectedDateTime?.getNullableTime();

  DateTime _getSelection() {
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime?.hour ?? 0,
      _selectedTime?.minute ?? 0,
    );
  }

  Future<TimeOfDay?> _pickTime(BuildContext context) async =>
      await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              datePickerTheme: DatePickerThemeData(
                dayStyle: TextStyle(fontSize: 12),
                weekdayStyle: TextStyle(fontSize: 12),
              ),
            ),
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateChanged: (newDate) =>
                  setState(() => _selectedDate = newDate),
            ),
          ),

          const Divider(height: 1),

          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            leading: const Icon(Icons.schedule),
            title: Row(
              children: [
                _selectedTime == null
                    ? Text(AppStrings.setTime)
                    : DismissibleChip(
                        label: _selectedTime!.toSimpleString(),
                        onDismiss: () => setState(() => _selectedTime = null),
                      ),
                Spacer(),
              ],
            ),
            onTap: () async {
              final time = await _pickTime(context);
              setState(() => _selectedTime = time);
            },
          ),

          Divider(height: 1),

          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            leading: Icon(Icons.repeat),
            title: const Text(AppStrings.repeat),
          ),

          Divider(height: 1),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              AppStrings.youWontBeNotified,
              style: TextStyle(fontSize: 13),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 20,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(AppStrings.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, _getSelection()),
                  child: const Text(AppStrings.done),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
