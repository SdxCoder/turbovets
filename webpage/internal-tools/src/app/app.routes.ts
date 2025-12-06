import { Routes } from '@angular/router';
import { TicketsComponent } from './tickets/tickets.component';
import { KnowledgebaseComponent } from './knowledgebase/knowledgebase.component';
import { LogsComponent } from './logs/logs.component';

export const routes: Routes = [
    { path: '', redirectTo: '/tickets', pathMatch: 'full' },
    { path: 'tickets', component: TicketsComponent },
    { path: 'knowledgebase', component: KnowledgebaseComponent },
    { path: 'logs', component: LogsComponent },
];
