import markdownItAttrs from 'markdown-it-attrs';

export default function(eleventyConfig) {
    eleventyConfig.addPassthroughCopy("cv.pdf");
    eleventyConfig.addPassthroughCopy("found.css");
    eleventyConfig.addPassthroughCopy("style.css");
    eleventyConfig.addPassthroughCopy("static");
    eleventyConfig.addPassthroughCopy("wander");

    eleventyConfig.amendLibrary("md", (mdLib) => mdLib.use(markdownItAttrs));

    // Restore VoiceOver list semantics stripped by list-style-type:none.
    eleventyConfig.amendLibrary("md", (mdLib) => {
        const defaultRender = mdLib.renderer.rules.bullet_list_open ||
            ((tokens, idx, options, env, self) => self.renderToken(tokens, idx, options));
        mdLib.renderer.rules.bullet_list_open = (tokens, idx, options, env, self) => {
            tokens[idx].attrSet("role", "list");
            return defaultRender(tokens, idx, options, env, self);
        };
    });

    // Add visually-hidden "(external link)" indicator to external links for screen readers.
    eleventyConfig.addTransform("external-link-a11y", (content, outputPath) => {
        if (!outputPath?.endsWith(".html")) return content;
        return content.replace(
            /<a\s([^>]*href="https?:\/\/(?!kaikuehne\.net)[^"]*"[^>]*)>([\s\S]*?)<\/a>/g,
            (match, attrs, inner) => {
                if (attrs.includes('aria-label')) return match;
                return `<a ${attrs}>${inner}<span class="visually-hidden"> (external link)</span></a>`;
            }
        );
    });
};
