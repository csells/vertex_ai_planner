import 'package:flutter/material.dart';

import '../data/plan_repository.dart';
import 'plan_view.dart';

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          children: [
            PlanView(
              plan: Plan(
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
            ),
            PlanView(
              plan: Plan(
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
            ),
          ],
        ),
      );
}
