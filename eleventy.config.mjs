import markdownItAttrs from 'markdown-it-attrs';

export default function(eleventyConfig) {
    eleventyConfig.addPassthroughCopy("cv.pdf");
    eleventyConfig.addPassthroughCopy("found.css");
    eleventyConfig.addPassthroughCopy("style.css");
    eleventyConfig.addPassthroughCopy("static");

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
};
