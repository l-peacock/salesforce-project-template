# Salesforce Project Template

An opinionated Salesforce project starter-kit.

## Summary

The key goals of this template is to provide:

- Ready-to-use code scanning and formatting capabilities
- Basic GitHub actions ready for extension
- Documentation auto-generation
- Local LWC Development capabilities
- A starting point for some development best practices

## Using Custom Code Templates

For simplicity, custom code templates have been included locally in this repository.

To start using the custom templates in VSCode, run:
`sfdx config:set customOrgMetadataTemplates=./code_templates`

If you plan to use these templates across multiple projects, these could also be stored in a remote repository. See the [Salesforce Developer Documentation](https://developer.salesforce.com/docs/platform/sfvscode-extensions/guide/byotemplate.html) for more details.
