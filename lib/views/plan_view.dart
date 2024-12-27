import 'package:flutter/material.dart';

import '../data/plan_repository.dart';

class PlanView extends StatelessWidget {
  PlanView({
    required int planIndex,
    required void Function() onRemovePlan,
    super.key,
  })  : _onRemovePlan = onRemovePlan,
        _planIndex = planIndex,
        _plan = PlanRepository.instance.plans[planIndex];

  final _repo = PlanRepository.instance;
  final int _planIndex;
  final Plan _plan;
  final void Function() _onRemovePlan;

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _plan.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: _onRemovePlan,
                    color: Colors.red[100],
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: _plan.items.length,
                  itemBuilder: (context, index) {
                    final item = _plan.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Radio<bool>(
                            toggleable: true,
                            value: true,
                            groupValue: item.isDone,
                            onChanged: (done) => _doneChanged(index, done),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _plan.items[index].title,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  void _doneChanged(int index, bool? done) => _repo.setPlanItemStatus(
        planIndex: _planIndex,
        itemIndex: index,
        isDone: done ?? false,
      );
}
