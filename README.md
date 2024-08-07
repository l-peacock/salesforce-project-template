# Salesforce Project Template

An opinionated Salesforce project starter-kit.

## Summary

The key goals of this template is to provide:

- Ready-to-use code scanning and formatting capabilities
- Basic GitHub actions ready for extension
- Documentation auto-generation
- Local LWC Development capabilities
- A starting point for some development best practices

## Trigger Handler Basics

A basic and light-weight trigger handler framework has been brought into this template - [`sfdc-trigger-framework`](https://github.com/kevinohara80/sfdc-trigger-framework).

This has been slightly modified to adhere to the styling and conventions of this template.

This could easily be replaced with your framework of choice, but I think this one is pretty neat.

## Apex Code Formatting Performance

Refer to the `prettier-plugin-apex` documentation on the different options to improve the performance of formatting Apex code locally.

This template uses the `native` parser by default, as this is my preferred option.

## Using Custom Code Templates

For simplicity, custom code templates have been included locally in this repository.

To start using the custom templates in VSCode, run:
`sfdx config:set customOrgMetadataTemplates=./code_templates`

If you plan to use these templates across multiple projects, these could also be stored in a remote repository. See the [Salesforce Developer Documentation](https://developer.salesforce.com/docs/platform/sfvscode-extensions/guide/byotemplate.html) for more details.
