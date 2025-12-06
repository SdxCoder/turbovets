import { Component, OnInit, OnDestroy, ElementRef, ViewChild, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';

interface LogEntry {
    id: number;
    timestamp: Date;
    level: 'INFO' | 'WARNING' | 'ERROR' | 'DEBUG';
    message: string;
    source: string;
}

@Component({
  selector: 'app-logs',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './logs.component.html'
})
export class LogsComponent implements OnInit, OnDestroy {
    @ViewChild('logsContainer') logsContainer!: ElementRef;

    logs: LogEntry[] = [];
    private logInterval: any;
    private logIdCounter = 1;
    isPaused = false;
    autoScroll = true;

    constructor(private cdr: ChangeDetectorRef) { }

    private logMessages = [
        'User authentication successful',
        'Database connection established',
        'Cache cleared successfully',
        'API request received',
        'Processing payment transaction',
        'Email notification sent',
        'File upload completed',
        'Session expired',
        'New user registered',
        'Report generated',
        'Backup completed',
        'Configuration updated',
        'System health check passed',
        'Resource cleanup initiated',
        'Webhook delivered'
    ];

    private sources = [
        'AuthService',
        'DatabaseService',
        'CacheService',
        'APIGateway',
        'PaymentProcessor',
        'EmailService',
        'FileService',
        'SessionManager',
        'UserService',
        'ReportService',
        'BackupService',
        'ConfigService',
        'HealthCheck',
        'CleanupService',
        'WebhookService'
    ];

    ngOnInit() {
        this.generateInitialLogs();
        this.startLogGeneration();
    }

    ngOnDestroy() {
        if (this.logInterval) {
            clearInterval(this.logInterval);
        }
    }

    generateInitialLogs() {
        for (let i = 0; i < 20; i++) {
            this.logs.push(this.generateRandomLog());
        }
    }

    startLogGeneration() {
        this.logInterval = setInterval(() => {
            if (!this.isPaused) {
                this.logs.push(this.generateRandomLog());

                if (this.logs.length > 100) {
                    this.logs.shift();
                }

                // Trigger Angular change detection
                this.cdr.detectChanges();

                if (this.autoScroll) {
                    setTimeout(() => this.scrollToBottom(), 0);
                }
            }
        }, 2000);
    }

    generateRandomLog(): LogEntry {
        const levels: Array<'INFO' | 'WARNING' | 'ERROR' | 'DEBUG'> = ['INFO', 'WARNING', 'ERROR', 'DEBUG'];
        const weights = [0.6, 0.25, 0.1, 0.05];

        const random = Math.random();
        let level: 'INFO' | 'WARNING' | 'ERROR' | 'DEBUG' = 'INFO';
        let cumulative = 0;

        for (let i = 0; i < weights.length; i++) {
            cumulative += weights[i];
            if (random <= cumulative) {
                level = levels[i];
                break;
            }
        }

        return {
            id: this.logIdCounter++,
            timestamp: new Date(),
            level,
            message: this.logMessages[Math.floor(Math.random() * this.logMessages.length)],
            source: this.sources[Math.floor(Math.random() * this.sources.length)]
        };
    }

    togglePause() {
        this.isPaused = !this.isPaused;
    }

    toggleAutoScroll() {
        this.autoScroll = !this.autoScroll;
        if (this.autoScroll) {
            this.scrollToBottom();
        }
    }

    clearLogs() {
        this.logs = [];
    }

    scrollToBottom() {
        if (this.logsContainer) {
            const element = this.logsContainer.nativeElement;
            element.scrollTop = element.scrollHeight;
        }
    }

    getLevelColor(level: string): string {
        switch (level) {
            case 'INFO': return 'text-blue-600 bg-blue-50';
            case 'WARNING': return 'text-yellow-600 bg-yellow-50';
            case 'ERROR': return 'text-red-600 bg-red-50';
            case 'DEBUG': return 'text-gray-600 bg-gray-50';
            default: return 'text-gray-600 bg-gray-50';
        }
    }

    getLevelIcon(level: string): string {
        switch (level) {
            case 'INFO': return 'ℹ️';
            case 'WARNING': return '⚠️';
            case 'ERROR': return '❌';
            case 'DEBUG': return '🔍';
            default: return '•';
        }
    }
}

