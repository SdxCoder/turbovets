# TurboVets Internal Tools Dashboard

Angular 18+ dashboard with Tailwind CSS for internal support tools.

## Features

### 1. Ticket Viewer
- View all support tickets in a responsive table
- Filter tickets by status (Open, In Progress, Closed)
- Display ticket details: ID, Subject, Status, Priority, Assignee, Created At
- Color-coded status badges and priority levels
- Dummy data with 15 sample tickets

### 2. Knowledgebase Editor
- Markdown editor with real-time preview
- Toolbar for quick formatting (Bold, Italic, Headings, Lists, Code, Links)
- Side-by-side editor and preview panels
- Save functionality
- Markdown quick reference guide
- Responsive layout (collapses to single column on mobile)

### 3. Live Logs Panel
- Real-time log streaming (new log every 2 seconds)
- Color-coded log levels (INFO, WARNING, ERROR, DEBUG)
- Pause/Resume log generation
- Auto-scroll to bottom (toggleable)
- Clear logs functionality
- Dark theme terminal-style interface
- Shows timestamp, level, source, and message for each log entry

## Setup Instructions

### Prerequisites
- Node.js 18+ and npm

### Installation

1. **Navigate to the project directory**
   ```bash
   cd webpage/internal-tools
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start the development server**
   ```bash
   npm start
   ```

4. **Open in browser**
   The server runs on `0.0.0.0:4200` (all network interfaces)
   
   **Access URLs by platform:**
   - **Desktop browser**: `http://localhost:4200`
   - **iOS Simulator**: `http://localhost:4200`
   - **Android Emulator**: `http://10.0.2.2:4200` (special alias for host's localhost)
   - **Physical device on same network**: `http://<YOUR_LOCAL_IP>:4200`
     - Mac: Run `ipconfig getifaddr en0` to get your IP
     - Windows: Run `ipconfig` and look for IPv4 Address
     - Linux: Run `hostname -I` or `ip addr show`

## Development

### Build for production
```bash
npm run build
```

### Run tests
```bash
npm test
```

### Serve production build
```bash
npm run build
npx http-server dist/internal-tools/browser -p 4200
```

## Project Structure

```
src/
├── app/
│   ├── app.ts                    # Main app component
│   ├── app.html                  # App layout with sidebar
│   ├── app.routes.ts             # Route configuration
│   ├── tickets/                  # Ticket Viewer component
│   ├── knowledgebase/            # Knowledgebase Editor component
│   └── logs/                     # Live Logs component
├── styles.css                    # Global styles with Tailwind
└── index.html                    # Main HTML file
```

## Tech Stack

- **Angular 18**: Latest Angular framework
- **Tailwind CSS**: Utility-first CSS framework
- **TypeScript**: Strongly typed JavaScript
- **Standalone Components**: Modern Angular component architecture
- **RxJS**: Reactive programming for real-time updates

## Responsive Design

The dashboard is **fully mobile-responsive** and works seamlessly across all devices:

### Mobile (< 768px)
- **Collapsible sidebar**: Hidden by default, opens as overlay
- **Top navigation bar**: Fixed header with menu button
- **Card-based tickets**: Stacked layout instead of table
- **Vertical editor**: Preview stacks below editor
- **Touch-friendly buttons**: Larger tap targets
- **Optimized text sizes**: Readable on small screens

### Tablet (768px - 1023px)
- **Persistent sidebar**: Always visible
- **Table view**: Full data table for tickets
- **Side-by-side editor**: Split view for knowledgebase
- **Adaptive spacing**: Optimized padding

### Desktop (1024px+)
- **Full sidebar**: Complete navigation with labels
- **Wide layout**: Maximum screen real estate
- **Enhanced spacing**: Comfortable desktop experience

**Key Features:**
- Mobile-first design approach
- Touch-optimized controls
- Responsive typography
- Adaptive layouts per component
- Overlay navigation on mobile
- Auto-close sidebar after mobile navigation

## Features Implementation

### Ticket Viewer
- Mock data generation for 15 tickets
- Filter by status with live count updates
- Responsive table with horizontal scroll on mobile
- Color-coded status badges (yellow for Open, blue for In Progress, green for Closed)
- Priority levels with color coding

### Knowledgebase Editor
- Real-time markdown rendering
- Toolbar with common formatting options
- Toggle preview on/off
- Basic markdown syntax support:
  - Headings (H1, H2, H3)
  - Bold and italic text
  - Code blocks and inline code
  - Lists
  - Links
  - Blockquotes
  - Horizontal rules
- Save button with success notification

### Live Logs
- Simulated real-time log generation (2-second intervals)
- Random log level distribution (60% INFO, 25% WARNING, 10% ERROR, 5% DEBUG)
- Auto-scroll feature
- Pause/Resume functionality
- Clear logs
- Maximum 100 logs kept in memory
- Terminal-style dark interface
- Timestamp with millisecond precision

## Notes

- All data is mocked/simulated - no backend required
- Logs are generated randomly and cleared on page refresh
- Knowledgebase articles are not persisted (no backend)
- Optimized for WebView integration with Flutter app
