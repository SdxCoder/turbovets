import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-knowledgebase',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './knowledgebase.component.html'
})
export class KnowledgebaseComponent {
    content: string = `# Welcome to the Knowledgebase Editor

## Getting Started
This is a simple markdown editor for creating and managing knowledgebase articles.

### Features
- **Real-time preview**: See your changes instantly
- **Markdown support**: Write using markdown syntax
- **Easy formatting**: Use the toolbar for quick formatting

## Common Issues

### Issue 1: Login Problems
If users are having trouble logging in:
1. Check credentials
2. Verify email confirmation
3. Reset password if needed

### Issue 2: Performance Issues
For slow performance:
- Clear browser cache
- Check internet connection
- Contact support team

## Tips
> Always save your work regularly!

\`\`\`
Code examples can be added like this
\`\`\`

---

*Last updated: ${new Date().toLocaleDateString()}*
`;

    showPreview: boolean = true;
    saveMessage: string = '';

    togglePreview() {
        this.showPreview = !this.showPreview;
    }

    saveArticle() {
        this.saveMessage = 'Article saved successfully!';
        setTimeout(() => {
            this.saveMessage = '';
        }, 3000);
    }

    insertMarkdown(syntax: string) {
        const textarea = document.getElementById('editor') as HTMLTextAreaElement;
        if (!textarea) return;

        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const selectedText = this.content.substring(start, end);

        let newText = '';
        switch (syntax) {
            case 'bold':
                newText = `**${selectedText || 'bold text'}**`;
                break;
            case 'italic':
                newText = `*${selectedText || 'italic text'}*`;
                break;
            case 'heading':
                newText = `## ${selectedText || 'Heading'}`;
                break;
            case 'list':
                newText = `\n- ${selectedText || 'List item'}`;
                break;
            case 'code':
                newText = `\`${selectedText || 'code'}\``;
                break;
            case 'link':
                newText = `[${selectedText || 'link text'}](url)`;
                break;
        }

        this.content = this.content.substring(0, start) + newText + this.content.substring(end);

        setTimeout(() => {
            textarea.focus();
            textarea.setSelectionRange(start + newText.length, start + newText.length);
        }, 0);
    }

    renderMarkdown(markdown: string): string {
        let html = markdown;

        html = html.replace(/^### (.*$)/gim, '<h3 class="text-xl font-bold mt-4 mb-2">$1</h3>');
        html = html.replace(/^## (.*$)/gim, '<h2 class="text-2xl font-bold mt-6 mb-3">$1</h2>');
        html = html.replace(/^# (.*$)/gim, '<h1 class="text-3xl font-bold mt-8 mb-4">$1</h1>');

        html = html.replace(/\*\*(.*?)\*\*/gim, '<strong class="font-bold">$1</strong>');
        html = html.replace(/\*(.*?)\*/gim, '<em class="italic">$1</em>');

        html = html.replace(/```([\s\S]*?)```/gim, '<pre class="bg-gray-100 p-4 rounded-lg my-4 overflow-x-auto"><code>$1</code></pre>');
        html = html.replace(/`(.*?)`/gim, '<code class="bg-gray-100 px-2 py-1 rounded text-sm">$1</code>');

        html = html.replace(/^> (.*$)/gim, '<blockquote class="border-l-4 border-blue-500 pl-4 py-2 my-4 text-gray-700 bg-blue-50">$1</blockquote>');

        html = html.replace(/^\- (.*$)/gim, '<li class="ml-6">$1</li>');
        html = html.replace(/(<li.*<\/li>)/gim, '<ul class="list-disc my-2">$1</ul>');

        html = html.replace(/\[(.*?)\]\((.*?)\)/gim, '<a href="$2" class="text-blue-600 hover:underline">$1</a>');

        html = html.replace(/^---$/gim, '<hr class="my-6 border-t border-gray-300">');

        html = html.replace(/\n/gim, '<br>');

        return html;
    }
}

