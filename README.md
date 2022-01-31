# Adobe Illustrator 👉🏻 PDF Action

[![Test the action](https://github.com/jv-k/ai-to-pdf-action/actions/workflows/test.yml/badge.svg)](https://github.com/jv-k/ai-to-pdf-action/actions/workflows/test.yml)

This workflow action uses [Ghostscript](https://www.ghostscript.com/) to convert Adobe Illustrator `.ai` files to `.pdf`.

| Parameter | Description | Required |
|-|-|-|
|`INPUT_FILE`| The .AI file to be converted. | Yes |
|`OUTPUT_FILE`| The name of the resulting PDF file. <br/> Default value: `output.pdf` | No |
|`OPTIONAL_PARAMS`| Additional arguments to be passed to Ghostscript. <br/>The following are already used by this Action and **cannot** be set: `sDEVICE`, `dNOPAUSE`, `dQUIET`, `dBATCH` `sOutputFile` | No |

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

