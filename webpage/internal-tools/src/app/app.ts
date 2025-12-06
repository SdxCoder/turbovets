import { Component } from '@angular/core';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterLink, RouterLinkActive, CommonModule],
  templateUrl: './app.html'
})
export class AppComponent {
  title = 'TurboVets Internal Tools';
  isSidebarOpen = false; // Start closed on mobile

  toggleSidebar() {
    this.isSidebarOpen = !this.isSidebarOpen;
  }

  closeSidebarOnMobile() {
    // Close sidebar on mobile after navigation
    if (window.innerWidth < 1024) {
      this.isSidebarOpen = false;
    }
  }
}
