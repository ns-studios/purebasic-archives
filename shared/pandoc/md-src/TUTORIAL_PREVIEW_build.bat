@ECHO OFF
ECHO ==============================================================================
ECHO                          BUILD TEMPLATE PREVIEW FILES                         
ECHO ==============================================================================
::   ==============================================================================
::                       BUILD MAIN SOURCE FROM MULTIPLE FILES                     
::   ==============================================================================
::   The markdown source file that will be fed to pandoc is built on the fly by
::   concatenating multilple sources. This allows snippets reusage across multiple
::   documents, and cleaner markdown sources to work with.
::   ------------------------------------------------------------------------------
ECHO Concatenating markdown source files:
ECHO -- TUTORIAL_PREVIEW_1.md
TYPE TUTORIAL_PREVIEW_1.md > TUTORIAL_PREVIEW.md
FOR /R %%i IN (code*.md) DO (
	ECHO -- %%~nxi
	ECHO. >> TUTORIAL_PREVIEW.md
	TYPE  %%i >> TUTORIAL_PREVIEW.md
)
ECHO ------------------------------------------------------------------------------
ECHO Invoking pandoc script for conversion to HTML.
SET "_SRC=%~dp0TUTORIAL_PREVIEW"
:: %%_SRC%% -- The full path of the source markdown doc, ".md" extension excluded.
::             Eg: "/full/path/md-src/source_filename" for a "source_filename.md" doc
::             (NOTE: ".md" extension left out).
SET "_DST=%~dp0..\TUTORIAL_PREVIEW"
:: %%_DST%% -- The full path of the final html document (extension excluded).
::             Eg: "/full/path/dest_filename" for a "dest_filename.html" doc (".html" left out).
::             Markdown source doc and final html file might be on different paths
::             or in same folder, have same name or a different one, according to use cases.
SET "_PATH2ROOT=../../"
:: %%_PATH2ROOT%% -- The path back to the repo's root from the final HTML doc (not
::                   from this batch file). Used by pandoc for setting relative path to
::                   CSS and JS files, and other shared resources.
CALL ..\%_PATH2ROOT%\shared\pandoc\tutorial_md2html.bat
ECHO ------------------------------------------------------------------------------
ECHO BUILD TEMPLATE PREVIEW FILES: DONE!