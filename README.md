# Adobe Illustrator 👉🏻 PDF Action

[![Test Conversion](https://github.com/jv-k/ai-to-pdf-action/actions/workflows/test.yml/badge.svg)](https://github.com/jv-k/ai-to-pdf-action/actions/workflows/test.yml)

This workflow action uses [Ghostscript](https://www.ghostscript.com/) to convert Adobe Illustrator `.ai` files to `.pdf`.

| Parameter | Description | Required |
|-|-|-|
|`INPUT_FILE`     | The .AI file to be converted. | Yes |
|`OUTPUT_FILE`    | The name of the resulting PDF file. <br/> Default value: `output.pdf` | No |
|`OPTIONAL_PARAMS`| Additional arguments to be passed to Ghostscript. <br/>The following are already used by this Action and **cannot** be set: `sDEVICE`, `dNOPAUSE`, `dQUIET`, `dBATCH` `sOutputFile` | No |
|`OVERWRITE`| 'Whether to overwrite existing files | No |
|`GH_COMMIT_MESSAGE`| Commit message. <br/> Default value: `chore: Converted AI 👉🏻 PDF` | No |
|`GH_USER`| The username of the user that will be used to commit the new files. <br/>Default value: The owner of the repo | No |

## Example usage

```yaml
name: Convert .AI 👉🏻 .PDF document
on: [push]
jobs:
    compress_pdf:
        runs-on: ubuntu-latest
        steps:
            - name: Set up Git repo
              uses: actions/checkout@v2 
            - name: Create PDF
              uses: jv-k/ai-to-pdf-action@v1  
              with:  
                INPUT_FILE: 'inputfile.ai'  
                OUTPUT_FILE: 'output.pdf'  
                OPTIONAL_PARAMS: '-dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer'  
```

## Contributing
I'd love you to contribute to `@jv-k/ai-to-pdf-action`, [pull requests](https://github.com/jv-k/ai-to-pdf-action/issues/new/choose) are welcome for submitting issues and bugs!

## License
The scripts and documentation in this project are released under the [MIT license](https://github.com/jv-k/ai-to-pdf-action/blob/master/LICENSE).
