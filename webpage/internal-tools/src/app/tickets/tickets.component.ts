import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

interface Ticket {
    id: string;
    subject: string;
    status: 'Open' | 'In Progress' | 'Closed';
    createdAt: Date;
    priority: 'Low' | 'Medium' | 'High';
    assignee: string;
}

@Component({
  selector: 'app-tickets',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './tickets.component.html'
})
export class TicketsComponent implements OnInit {
    tickets: Ticket[] = [];
    filteredTickets: Ticket[] = [];
    selectedFilter: 'All' | 'Open' | 'In Progress' | 'Closed' = 'All';

    ngOnInit() {
        this.tickets = this.generateMockTickets();
        this.filteredTickets = this.tickets;
    }

    generateMockTickets(): Ticket[] {
        const subjects = [
            'Patient record not loading',
            'Appointment scheduling issue',
            'Billing discrepancy',
            'Unable to upload lab results',
            'Prescription refill request',
            'Emergency contact not updating',
            'Mobile app crash on login',
            'Email notifications not working',
            'Report generation timeout',
            'User permissions not syncing'
        ];

        const statuses: Array<'Open' | 'In Progress' | 'Closed'> = ['Open', 'In Progress', 'Closed'];
        const priorities: Array<'Low' | 'Medium' | 'High'> = ['Low', 'Medium', 'High'];
        const assignees = ['Dr. Smith', 'Dr. Johnson', 'Dr. Williams', 'Support Team', 'Tech Team'];

        return Array.from({ length: 15 }, (_, i) => ({
            id: `TKT-${1000 + i}`,
            subject: subjects[i % subjects.length],
            status: statuses[i % statuses.length],
            createdAt: new Date(Date.now() - Math.random() * 7 * 24 * 60 * 60 * 1000),
            priority: priorities[i % priorities.length],
            assignee: assignees[i % assignees.length]
        }));
    }

    filterTickets(status: 'All' | 'Open' | 'In Progress' | 'Closed') {
        this.selectedFilter = status;
        if (status === 'All') {
            this.filteredTickets = this.tickets;
        } else {
            this.filteredTickets = this.tickets.filter(t => t.status === status);
        }
    }

    getStatusColor(status: string): string {
        switch (status) {
            case 'Open': return 'bg-yellow-100 text-yellow-800';
            case 'In Progress': return 'bg-blue-100 text-blue-800';
            case 'Closed': return 'bg-green-100 text-green-800';
            default: return 'bg-gray-100 text-gray-800';
        }
    }

    getPriorityColor(priority: string): string {
        switch (priority) {
            case 'High': return 'text-red-600';
            case 'Medium': return 'text-orange-600';
            case 'Low': return 'text-green-600';
            default: return 'text-gray-600';
        }
    }
}

