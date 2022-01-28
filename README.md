# ai-to-pdf-action

This workflow action uses [Ghostscript](https://www.ghostscript.com/) to convert Adobe Illustrator `.ai` files to `.pdf`.

## Parameters

### `INPUT_FILE`

**Required** The .AI file to be converted.

### `OUTPUT_FILE`

The name of the resulting PDF file.  

Default value: `"output.pdf"`.

### `OPTIONAL_PARAMS`

Additional arguments to be passed to Ghostscript (except sDEVICE, dNOPAUSE, dQUIET, dBATCH and sOutputFile that cannot be set)

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

