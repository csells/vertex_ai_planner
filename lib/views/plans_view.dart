import 'package:flutter/material.dart';

import '../data/plan_repository.dart';
import 'plan_view.dart';

class PlansView extends StatelessWidget {
  PlansView({super.key}) {
    // TODO: remove
    if (PlanRepository.instance.plans.isEmpty) {
      PlanRepository.instance
        ..addPlan(
          Plan(
            title: 'Santorini Trip for 5',
            items: [
              PlanItem(title: 'Flights and Accommodation'),
              PlanItem(title: 'Transportation in Santorini'),
              PlanItem(title: 'Activities for all ages'),
              PlanItem(title: '50th Birthday Celebration'),
              PlanItem(title: 'Toddler-Specific Needs'),
              PlanItem(title: 'Itinerary and Bookings'),
              PlanItem(title: 'Emergency Contacts and Insurance'),
            ],
          ),
        )
        ..addPlan(
          Plan(
            title: 'Superhero Kids Room',
            items: [
              PlanItem(title: 'Clear the clutter'),
              PlanItem(title: 'Organize books and toys'),
              PlanItem(title: 'Superhero theme decorations'),
              PlanItem(title: 'Install superhero bedding'),
              PlanItem(title: 'Set up play area'),
              PlanItem(title: 'Add storage solutions'),
            ],
          ),
        );
    }
  }

  final PlanRepository _repo = PlanRepository.instance;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListenableBuilder(
          listenable: _repo,
          builder: (context, child) => ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var planIndex = 0;
                  planIndex < PlanRepository.instance.plans.length;
                  planIndex++)
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PlanView(
                      planIndex: planIndex,
                      onRemovePlan: () => _repo.removePlan(planIndex),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
