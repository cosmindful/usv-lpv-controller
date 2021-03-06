function export_overlay(filename, output, rect)
% EXPORT_OVERLAY    Exports images/figures to Google Earth kmz files
%
% SYNTAX:
%   export_overlay(filename, output, rect)
%       export_overlay(filename, output, [N, S, E, W])
%       export_overlay(filename, output, [N, S, E, W, R])
%
% INPUT: 
%     filename: must be either 
%                 1. Google Earth supported image file (see below), OR
%                 2. MATLAB format .fig file, OR
%                 3. a figure object handle (use gcf for current figure)
%
%     output: .kmz file (relative or full path)
%
%     rect: 4 or 5-element vector in the following format: 
%           (4 element vector assumes 0 rotation)
%             [north boundary, south bound, east bound, west bound, rotation]
%
%
% NOTE: If you specify a figure handle or .fig file, it will be exported
%       as a TRANSPARENT .png file.
%
% GOOGLE EARTH SUPPORTED FORMATS:
%     .bmp, .dds, .gif, .jpg, .pgm, .png, .ppm, .tga, .tiff, .tif
%
%
% EXAMPLE 1:
%     % this will place an overlay of a random plot over Hawaii.
%     plot(1:1:10, rand(10,1), 'w');
%     rect = [21.37, 21.36, -157.971, -157.973];
%     export_overlay(gcf, 'output.kmz', rect);
%
% EXAMPLE 2:
%     % this will overlay a PNG image over the same location.
%     % (Assuming 'contour.png' is defined)
%     rect = [21.37, 21.36, -157.971, -157.973];
%     export_overlay('contour.png', 'contour.kmz', rect);
%
% EXAMPLE 3:
%     % you may also use full or relative paths to various images you would
%     % like to overlay.
%     rect = [21.37, 21.36, -157.971, -157.973];
%     file1 = '/home/user/Desktop/contour.png';
%     file2 = 'figfiles/myfig.fig';
%     export_overlay(file1, 'contour.kmz', rect);
%     export_overlay(file2, 'myfig.kmz', rect);
%

%
% Cameron Sparr - Nov. 1, 2011
% cameronsparr@gmail.com
%

% Thanks to Oliver Woodford for writing the invaluable export_fig function
% and for his advice in simplifying export_overlay and improving it for the
% latest MATLAB releases.
    
    % Google Earth supported formats...
    supp = {'.bmp', '.dds', '.gif', '.jpg', '.pgm', '.png', ...
        '.ppm', '.tga', '.tiff', '.tif'};
    
    % if input filename is a graphics handle, save the figure as a
    % temporary .fig file
    if ishandle(filename)
        saveas(filename, 'temp.fig');
        filename = 'temp.fig';
        close(gcf);
    end
    
    % Check size of rect and determine rotation
    if length(rect) == 5
        rotation = rect(5);
    elseif length(rect) == 4
        rotation = 0;
    else
        if length(rect) > 5
            error('Too many elements in rect');
        else
            error('Not enough elements in rect');
        end
    end    
    
    % decompose input and output file names
    [inpathstr, inname, inext] = fileparts(filename);
    [opathstr, oname, oext] = fileparts(output);
    
    % output file must be .kmz
    if ~strcmp(oext,'.kmz')
        error('output file must have a .kmz extension');
    end
    
    % make 'files' directory, this is where .kmz files house their image
    % files
    filespath = fullfile(opathstr, 'files');
    mkdir(filespath);
    kmlpath = fullfile(opathstr, 'doc.kml');
    kmlfile = fopen(kmlpath, 'w');

    
    % check if input file is in the Google Earth supported files list.
    supprtd = strcmp(inext,supp);
    % if input file is a fig, set the background to transparent and use the
    % export_fig tool to export it into a png.
    if strcmp(inext, '.fig')
        open(filename);
        set(gca, 'color', 'none');
        outname = 'overlay.png';
        outfig = fullfile(opathstr, 'files', outname);
        export_fig(outfig, '-transparent');
        close(gcf);
    elseif any(supprtd) % if supported, copy to 'files' folder
        outname = ['overlay', char(supp(supprtd))];
        outfig = fullfile(opathstr, 'files', outname);
        copyfile(filename, outfig);
    else
        error('Unsupported input file format');
    end
    
    % Write .kml file...
    fprintf(kmlfile, '<?xml version="1.0" encoding="UTF-8"?>\n');
    fprintf(kmlfile, '<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
    fprintf(kmlfile, '<GroundOverlay>\n');
    fprintf(kmlfile, ['	<name>', oname, '</name>\n']);
    fprintf(kmlfile, '	<Icon>\n');
    fprintf(kmlfile, ['		<href>files/', outname, '</href>\n']);
    fprintf(kmlfile, '		<viewBoundScale>0.75</viewBoundScale>\n');
    fprintf(kmlfile, '	</Icon>\n');
    fprintf(kmlfile, '	<LatLonBox>\n');
    fprintf(kmlfile, ['		<north>', num2str(rect(1)), '</north>\n']);
    fprintf(kmlfile, ['		<south>', num2str(rect(2)), '</south>\n']);
    fprintf(kmlfile, ['		<east>', num2str(rect(3)), '</east>\n']);
    fprintf(kmlfile, ['		<west>', num2str(rect(4)), '</west>\n']);
    fprintf(kmlfile, ['		<rotation>', num2str(rotation), '</rotation>\n']);
    fprintf(kmlfile, '	</LatLonBox>\n');
    fprintf(kmlfile, '</GroundOverlay>\n');
    fprintf(kmlfile, '</kml>');
    fclose(kmlfile);
    
    % zip doc.kml and /files/overlay.xxx together
    zip(output, {kmlpath, filespath});
    % rename .kmz.zip file into just .kmz
    copyfile([output, '.zip'], output);
    
    % delete directories and files now contained within the output .kmz file
    rmdir(filespath, 's');
    delete(kmlpath);
    delete([output, '.zip']);
    
%EXPORT_FIG  Exports figures suitable for publication
%
% Examples:
%   im = export_fig
%   [im alpha] = export_fig
%   export_fig filename
%   export_fig filename -format1 -format2
%   export_fig ... -nocrop
%   export_fig ... -transparent
%   export_fig ... -native
%   export_fig ... -m<val>
%   export_fig ... -r<val>
%   export_fig ... -a<val>
%   export_fig ... -q<val>
%   export_fig ... -<renderer>
%   export_fig ... -<colorspace>
%   export_fig ... -append
%   export_fig(..., handle)
%
% This function saves a figure or single axes to one or more vector and/or
% bitmap file formats, and/or outputs a rasterized version to the
% workspace, with the following properties:
%   - Figure/axes reproduced as it appears on screen
%   - Cropped borders (optional)
%   - Embedded fonts (vector formats)
%   - Improved line and grid line styles
%   - Anti-aliased graphics (bitmap formats)
%   - Render images at native resolution (optional for bitmap formats)
%   - Transparent background supported (pdf, eps, png)
%   - Semi-transparent patch objects supported (png only)
%   - RGB, CMYK or grayscale output (CMYK only with pdf, eps, tiff)
%   - Variable image compression, including lossless (pdf, eps, jpg)
%   - Optionally append to file (pdf, tiff)
%   - Vector formats: pdf, eps
%   - Bitmap formats: png, tiff, jpg, bmp, export to workspace 
%   
% This function is especially suited to exporting figures for use in
% publications and presentations, because of the high quality and
% portability of media produced.
%
% Note that the background color and figure dimensions are reproduced
% (the latter approximately, and ignoring cropping & magnification) in the
% output file. For transparent background (and semi-transparent patch
% objects), use the -transparent option or set the figure 'Color' property
% to 'none'. To make axes transparent set the axes 'Color' property to
% 'none'. Pdf, eps and png are the only file formats to support a
% transparent background, whilst the png format alone supports transparency
% of patch objects.
%
% The choice of renderer (opengl, zbuffer or painters) has a large impact
% on the quality of output. Whilst the default value (opengl for bitmaps,
% painters for vector formats) generally gives good results, if you aren't
% satisfied then try another renderer.  Notes: 1) For vector formats (eps,
% pdf), only painters generates vector graphics. 2) For bitmaps, only
% opengl can render transparent patch objects correctly. 3) For bitmaps,
% only painters will correctly scale line dash and dot lengths when
% magnifying or anti-aliasing. 4) Fonts may be substitued with Courier when
% using painters.
%
% When exporting to vector format (pdf & eps) and bitmap format using the
% painters renderer, this function requires that ghostscript is installed
% on your system. You can download this from:
%   http://www.ghostscript.com
% When exporting to eps it additionally requires pdftops, from the Xpdf
% suite of functions. You can download this from:
%   http://www.foolabs.com/xpdf
%
%IN:
%   filename - string containing the name (optionally including full or
%              relative path) of the file the figure is to be saved as. If
%              a path is not specified, the figure is saved in the current
%              directory. If no name and no output arguments are specified,
%              the default name, 'export_fig_out', is used. If neither a
%              file extension nor a format are specified, a ".png" is added
%              and the figure saved in that format.
%   -format1, -format2, etc. - strings containing the extensions of the
%                              file formats the figure is to be saved as.
%                              Valid options are: '-pdf', '-eps', '-png',
%                              '-tif', '-jpg' and '-bmp'. All combinations
%                              of formats are valid.
%   -nocrop - option indicating that the borders of the output are not to
%             be cropped.
%   -transparent - option indicating that the figure background is to be
%                  made transparent (png, pdf and eps output only).
%   -m<val> - option where val indicates the factor to magnify the
%             on-screen figure dimensions by when generating bitmap
%             outputs. Default: '-m1'.
%   -r<val> - option val indicates the resolution (in pixels per inch) to
%             export bitmap outputs at, keeping the dimensions of the
%             on-screen figure. Default: sprintf('-r%g', get(0,
%             'ScreenPixelsPerInch')). Note that the -m and -r options
%             change the same property.
%   -native - option indicating that the output resolution (when outputting
%             a bitmap format) should be such that the vertical resolution
%             of the first suitable image found in the figure is at the
%             native resolution of that image. To specify a particular
%             image to use, give it the tag 'export_fig_native'. Notes:
%             This overrides any value set with the -m and -r options. It
%             also assumes that the image is displayed front-to-parallel
%             with the screen. The output resolution is approximate and
%             should not be relied upon. Anti-aliasing can have adverse
%             effects on image quality (disable with the -a1 option).
%   -a1, -a2, -a3, -a4 - option indicating the amount of anti-aliasing to
%                        use for bitmap outputs. '-a1' means no anti-
%                        aliasing; '-a4' is the maximum amount (default).
%   -<renderer> - option to force a particular renderer (painters, opengl
%                 or zbuffer) to be used over the default: opengl for
%                 bitmaps; painters for vector formats.
%   -<colorspace> - option indicating which colorspace color figures should
%                   be saved in: RGB (default), CMYK or gray. CMYK is only
%                   supported in pdf, eps and tiff output.
%   -q<val> - option to vary bitmap image quality (in pdf, eps and jpg
%             files only).  Larger val, in the range 0-100, gives higher
%             quality/lower compression. val > 100 gives lossless
%             compression. Default: '-q95' for jpg, ghostscript prepress
%             default for pdf & eps. Note: lossless compression can
%             sometimes give a smaller file size than the default lossy
%             compression, depending on the type of images.
%   -append - option indicating that if the file (pdfs only) already
%             exists, the figure is to be appended as a new page, instead
%             of being overwritten (default).
%   handle - The handle of the figure or axes (can be an array of handles
%            of several axes, but these must be in the same figure) to be
%            saved. Default: gcf.
%
%OUT:
%   im - MxNxC uint8 image array of the figure.
%   alpha - MxN single array of alphamatte values in range [0,1], for the
%           case when the background is transparent.
%
%   Some helpful examples and tips can be found at:
%      http://sites.google.com/site/oliverwoodford/software/export_fig
%
%   See also PRINT, SAVEAS.

% Copyright (C) Oliver Woodford 2008-2011

% The idea of using ghostscript is inspired by Peder Axensten's SAVEFIG
% (fex id: 10889) which is itself inspired by EPS2PDF (fex id: 5782).
% The idea for using pdftops came from the MATLAB newsgroup (id: 168171).
% The idea of editing the EPS file to change line styles comes from Jiro
% Doke's FIXPSLINESTYLE (fex id: 17928).
% The idea of changing dash length with line width came from comments on
% fex id: 5743, but the implementation is mine :)
% The idea of anti-aliasing bitmaps came from Anders Brun's MYAA (fex id:
% 20979).
% The idea of appending figures in pdfs came from Matt C in comments on the
% FEX (id: 23629)

% Thanks to Roland Martin for pointing out the colour MATLAB
% bug/feature with colorbar axes and transparent backgrounds.
% Thanks also to Andrew Matthews for describing a bug to do with the figure
% size changing in -nodisplay mode. I couldn't reproduce it, but included a
% fix anyway.
% Thanks to Tammy Threadgill for reporting a bug where an axes is not
% isolated from gui objects.

function [im alpha] = export_fig(varargin)
% Parse the input arguments
[fig options] = parse_args(nargout, varargin{:});
% Isolate the subplot, if it is one
cls = strcmp(get(fig(1), 'Type'), 'axes');
if cls
    % Given handles of one or more axes, so isolate them from the rest
    fig = isolate_axes(fig);
else
    old_mode = get(fig, 'InvertHardcopy');
end
% Hack the font units where necessary (due to a font rendering bug in
% print?). This may not work perfectly in all cases. Also it can change the
% figure layout if reverted, so use a copy.
magnify = options.magnify * options.aa_factor;
if isbitmap(options) && magnify ~= 1
    fontu = findobj(fig, 'FontUnits', 'normalized');
    if ~isempty(fontu)
        % Some normalized font units found
        if ~cls
            fig = copyfig(fig);
            set(fig, 'Visible', 'off');
            fontu = findobj(fig, 'FontUnits', 'normalized');
            cls = true;
        end
        set(fontu, 'FontUnits', 'points');
    end
end
% Set to print exactly what is there
set(fig, 'InvertHardcopy', 'off');
% Set the renderer
switch options.renderer
    case 1
        renderer = '-opengl';
    case 2
        renderer = '-zbuffer';
    case 3
        renderer = '-painters';
    otherwise
        renderer = '-opengl'; % Default for bitmaps
end
% Do the bitmap formats first
if isbitmap(options)
    % Get the background colour
    if options.transparent && (options.png || options.alpha)
        % Get out an alpha channel
        % MATLAB "feature": black colorbar axes can change to white and vice versa!
        hCB = findobj(fig, 'Type', 'axes', 'Tag', 'Colorbar');
        if isempty(hCB)
            yCol = [];
            xCol = [];
        else
            yCol = get(hCB, 'YColor');
            xCol = get(hCB, 'XColor');
            if iscell(yCol)
                yCol = cell2mat(yCol);
                xCol = cell2mat(xCol);
            end
            yCol = sum(yCol, 2);
            xCol = sum(xCol, 2);
        end
        % MATLAB "feature": apparently figure size can change when changing
        % colour in -nodisplay mode
        pos = get(fig, 'Position');
        % Set the background colour to black, and set size in case it was
        % changed internally
        tcol = get(fig, 'Color');
        set(fig, 'Color', 'k', 'Position', pos);
        % Correct the colorbar axes colours
        set(hCB(yCol==0), 'YColor', [0 0 0]);
        set(hCB(xCol==0), 'XColor', [0 0 0]);
        % Print large version to array
        B = print2array(fig, magnify, renderer);
        % Downscale the image
        B = downsize(single(B), options.aa_factor);
        % Set background to white (and set size)
        set(fig, 'Color', 'w', 'Position', pos);
        % Correct the colorbar axes colours
        set(hCB(yCol==3), 'YColor', [1 1 1]);
        set(hCB(xCol==3), 'XColor', [1 1 1]);
        % Print large version to array
        A = print2array(fig, magnify, renderer);
        % Downscale the image
        A = downsize(single(A), options.aa_factor);
        % Set the background colour (and size) back to normal
        set(fig, 'Color', tcol, 'Position', pos);
        % Compute the alpha map
        alpha = round(sum(B - A, 3)) / (255 * 3) + 1;
        A = alpha;
        A(A==0) = 1;
        A = B ./ A(:,:,[1 1 1]);
        clear B
        % Convert to greyscale
        if options.colourspace == 2
            A = rgb2grey(A);
        end
        A = uint8(A);
        % Crop the background
        if options.crop
            [alpha v] = crop_background(alpha, 0);
            A = A(v(1):v(2),v(3):v(4),:);
        end
        if options.png
            % Compute the resolution
            res = options.magnify * get(0, 'ScreenPixelsPerInch') / 25.4e-3;
            % Save the png
            imwrite(A, [options.name '.png'], 'Alpha', double(alpha), 'ResolutionUnit', 'meter', 'XResolution', res, 'YResolution', res);
            % Clear the png bit
            options.png = false;
        end
        % Return only one channel for greyscale
        if isbitmap(options)
            A = check_greyscale(A);
        end
        if options.alpha
            % Store the image
            im = A;
            % Clear the alpha bit
            options.alpha = false;
        end
        % Get the non-alpha image
        if isbitmap(options)
            alph = alpha(:,:,ones(1, size(A, 3)));
            A = uint8(single(A) .* alph + 255 * (1 - alph));
            clear alph
        end
        if options.im
            % Store the new image
            im = A;
        end
    else
        % Print large version to array
        if options.transparent
            % MATLAB "feature": apparently figure size can change when changing
            % colour in -nodisplay mode
            pos = get(fig, 'Position');
            tcol = get(fig, 'Color');
            set(fig, 'Color', 'w', 'Position', pos);
            A = print2array(fig, magnify, renderer);
            set(fig, 'Color', tcol, 'Position', pos);
            tcol = 255;
        else
            [A tcol] = print2array(fig, magnify, renderer);
        end
        % Crop the background
        if options.crop
            A = crop_background(A, tcol);
        end
        % Downscale the image
        A = downsize(A, options.aa_factor);
        if options.colourspace == 2
            % Convert to greyscale
            A = rgb2grey(A);
        else
            % Return only one channel for greyscale
            A = check_greyscale(A);
        end
        % Outputs
        if options.im
            im = A;
        end
        if options.alpha
            im = A;
            alpha = zeros(size(A, 1), size(A, 2), 'single');
        end
    end
    % Save the images
    if options.png
        res = options.magnify * get(0, 'ScreenPixelsPerInch') / 25.4e-3;
        imwrite(A, [options.name '.png'], 'ResolutionUnit', 'meter', 'XResolution', res, 'YResolution', res);
    end
    if options.bmp
        imwrite(A, [options.name '.bmp']);
    end
    % Save jpeg with given quality
    if options.jpg
        quality = options.quality;
        if isempty(quality)
            quality = 95;
        end
        if quality > 100
            imwrite(A, [options.name '.jpg'], 'Mode', 'lossless');
        else
            imwrite(A, [options.name '.jpg'], 'Quality', quality);
        end
    end
    % Save tif images in cmyk if wanted (and possible)
    if options.tif
        if options.colourspace == 1 && size(A, 3) == 3
            A = double(255 - A);
            K = min(A, [], 3);
            K_ = 255 ./ max(255 - K, 1);
            C = (A(:,:,1) - K) .* K_;
            M = (A(:,:,2) - K) .* K_;
            Y = (A(:,:,3) - K) .* K_;
            A = uint8(cat(3, C, M, Y, K));
            clear C M Y K K_
        end
        append_mode = {'overwrite', 'append'};
        imwrite(A, [options.name '.tif'], 'Resolution', options.magnify*get(0, 'ScreenPixelsPerInch'), 'WriteMode', append_mode{options.append+1});
    end
end
% Now do the vector formats
if isvector(options)
    % Set the default renderer to painters
    if ~options.renderer
        renderer = '-painters';
    end
    % Generate some filenames
    tmp_nam = [tempname '.eps'];
    if options.pdf
        pdf_nam = [options.name '.pdf'];
    else
        pdf_nam = [tempname '.pdf'];
    end
    % Generate the options for print
    p2eArgs = {renderer};
    if options.colourspace == 1
        p2eArgs = [p2eArgs {'-cmyk'}];
    end
    if ~options.crop
        p2eArgs = [p2eArgs {'-loose'}];
    end
    try
        % Generate an eps
        print2eps(tmp_nam, fig, p2eArgs{:});
        % Remove the background, if desired
        if options.transparent && ~isequal(get(fig, 'Color'), 'none')
            eps_remove_background(tmp_nam);
        end
        % Generate a pdf
        eps2pdf(tmp_nam, pdf_nam, 1, options.append, options.colourspace==2, options.quality);
    catch ex
        % Delete the eps
        delete(tmp_nam);
        rethrow(ex);
    end
    % Delete the eps
    delete(tmp_nam);
    if options.eps
        try
            % Generate an eps from the pdf
            pdf2eps(pdf_nam, [options.name '.eps']);
        catch ex
            if ~options.pdf
                % Delete the pdf
                delete(pdf_nam);
            end
            rethrow(ex);
        end
        if ~options.pdf
            % Delete the pdf
            delete(pdf_nam);
        end
    end
end
if cls
    % Close the created figure
    close(fig);
else
    % Reset the hardcopy mode
    set(fig, 'InvertHardcopy', old_mode);
end
return

function [fig options] = parse_args(nout, varargin)
% Parse the input arguments
% Set the defaults
fig = get(0, 'CurrentFigure');
options = struct('name', 'export_fig_out', ...
                 'crop', true, ...
                 'transparent', false, ...
                 'renderer', 0, ... % 0: default, 1: OpenGL, 2: ZBuffer, 3: Painters
                 'pdf', false, ...
                 'eps', false, ...
                 'png', false, ...
                 'tif', false, ...
                 'jpg', false, ...
                 'bmp', false, ...
                 'colourspace', 0, ... % 0: RGB/gray, 1: CMYK, 2: gray
                 'append', false, ...
                 'im', nout == 1, ...
                 'alpha', nout == 2, ...
                 'aa_factor', 3, ...
                 'magnify', 1, ...
                 'quality', []);
native = false; % Set resolution to native of an image

% Go through the other arguments
for a = 1:nargin-1
    if all(ishandle(varargin{a}))
        fig = varargin{a};
    elseif ischar(varargin{a}) && ~isempty(varargin{a})
        if varargin{a}(1) == '-'
            switch lower(varargin{a}(2:end))
                case 'nocrop'
                    options.crop = false;
                case {'trans', 'transparent'}
                    options.transparent = true;
                case 'opengl'
                    options.renderer = 1;
                case 'zbuffer'
                    options.renderer = 2;
                case 'painters'
                    options.renderer = 3;
                case 'pdf'
                    options.pdf = true;
                case 'eps'
                    options.eps = true;
                case 'png'
                    options.png = true;
                case {'tif', 'tiff'}
                    options.tif = true;
                case {'jpg', 'jpeg'}
                    options.jpg = true;
                case 'bmp'
                    options.bmp = true;
                case 'rgb'
                    options.colourspace = 0;
                case 'cmyk'
                    options.colourspace = 1;
                case {'gray', 'grey'}
                    options.colourspace = 2;
                case {'a1', 'a2', 'a3', 'a4'}
                    options.aa_factor = str2double(varargin{a}(3));
                case 'append'
                    options.append = true;
                case 'native'
                    native = true;
                otherwise
                    val = str2double(regexp(varargin{a}, '(?<=-(m|M|r|R|q|Q))(\d*\.)?\d+(e-?\d+)?', 'match'));
                    if ~isscalar(val)
                        error('option %s not recognised', varargin{a});
                    end
                    switch lower(varargin{a}(2))
                        case 'm'
                            options.magnify = val;
                        case 'r'
                            options.magnify = val ./ get(0, 'ScreenPixelsPerInch');
                        case 'q'
                            options.quality = max(val, 0);
                    end
            end
        else
            [p options.name ext] = fileparts(varargin{a});
            if ~isempty(p)
                options.name = [p filesep options.name];
            end
            switch lower(ext)
                case {'.tif', '.tiff'}
                    options.tif = true;
                case {'.jpg', '.jpeg'}
                    options.jpg = true;
                case '.png'
                    options.png = true;
                case '.bmp'
                    options.bmp = true;
                case '.eps'
                    options.eps = true;
                case '.pdf'
                    options.pdf = true;
                otherwise
                    options.name = varargin{a};
            end
        end
    end
end

% Check we have a figure handle
if isempty(fig)
    error('No figure found');
end

% Set the default format
if ~isvector(options) && ~isbitmap(options)
    options.png = true;
end

% Check whether transparent background is wanted (old way)
if isequal(get(fig, 'Color'), 'none')
    options.transparent = true;
end

% If requested, set the resolution to the native vertical resolution of the
% first suitable image found
if native && isbitmap(options)
    % Find a suitable image
    list = findobj(fig, 'Type', 'image', 'Tag', 'export_fig_native');
    if isempty(list)
        list = findobj(fig, 'Type', 'image', 'Visible', 'on');
    end
    for hIm = list(:)'
        % Check height is >= 2
        height = size(get(hIm, 'CData'), 1);
        if height < 2
            continue
        end
        % Account for the image filling only part of the axes, or vice
        % versa
        yl = get(hIm, 'YData');
        if isscalar(yl)
            yl = [yl(1)-0.5 yl(1)+height+0.5];
        else
            if ~diff(yl)
                continue
            end
            yl = yl + [-0.5 0.5] * (diff(yl) / (height - 1));
        end
        hAx = get(hIm, 'Parent');
        yl2 = get(hAx, 'YLim');
        % Find the pixel height of the axes
        oldUnits = get(hAx, 'Units');
        set(hAx, 'Units', 'pixels');
        pos = get(hAx, 'Position');
        set(hAx, 'Units', oldUnits);
        if ~pos(4)
            continue
        end
        % Found a suitable image
        % Account for stretch-to-fill being disabled
        pbar = get(hAx, 'PlotBoxAspectRatio');
        pos = min(pos(4), pbar(2)*pos(3)/pbar(1));
        % Set the magnification to give native resolution
        options.magnify = (height * diff(yl2)) / (pos * diff(yl));
        break
    end
end
return

function A = downsize(A, factor)
% Downsample an image
if factor == 1
    % Nothing to do
    return
end
try
    % Faster, but requires image processing toolbox
    A = imresize(A, 1/factor, 'bilinear');
catch
    % No image processing toolbox - resize manually
    % Lowpass filter - use Gaussian as is separable, so faster
    % Compute the 1d Gaussian filter
    filt = (-factor-1:factor+1) / (factor * 0.6);
    filt = exp(-filt .* filt);
    % Normalize the filter
    filt = single(filt / sum(filt));
    % Filter the image
    padding = floor(numel(filt) / 2);
    for a = 1:size(A, 3)
        A(:,:,a) = conv2(filt, filt', single(A([ones(1, padding) 1:end repmat(end, 1, padding)],[ones(1, padding) 1:end repmat(end, 1, padding)],a)), 'valid');
    end
    % Subsample
    A = A(1+floor(mod(end-1, factor)/2):factor:end,1+floor(mod(end-1, factor)/2):factor:end,:);
end
return

function A = rgb2grey(A)
A = cast(reshape(reshape(single(A), [], 3) * single([0.299; 0.587; 0.114]), size(A, 1), size(A, 2)), class(A));
return

function A = check_greyscale(A)
% Check if the image is greyscale
if size(A, 3) == 3 && ...
        all(reshape(A(:,:,1) == A(:,:,2), [], 1)) && ...
        all(reshape(A(:,:,2) == A(:,:,3), [], 1))
    A = A(:,:,1); % Save only one channel for 8-bit output
end
return

function [A v] = crop_background(A, bcol)
% Map the foreground pixels
[h w c] = size(A);
if isscalar(bcol) && c > 1
    bcol = bcol(ones(1, c));
end
bail = false;
for l = 1:w
    for a = 1:c
        if ~all(A(:,l,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for r = w:-1:l
    for a = 1:c
        if ~all(A(:,r,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for t = 1:h
    for a = 1:c
        if ~all(A(t,:,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for b = h:-1:t
    for a = 1:c
        if ~all(A(b,:,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
% Crop the background, leaving one boundary pixel to avoid bleeding on
% resize
v = [max(t-1, 1) min(b+1, h) max(l-1, 1) min(r+1, w)];
A = A(v(1):v(2),v(3):v(4),:);
return

function eps_remove_background(fname)
% Remove the background of an eps file
% Open the file
fh = fopen(fname, 'r+');
if fh == -1
    error('Not able to open file %s.', fname);
end
% Read the file line by line
while true
    % Get the next line
    l = fgets(fh);
    if isequal(l, -1)
        break; % Quit, no rectangle found
    end
    % Check if the line contains the background rectangle
    if isequal(regexp(l, ' *0 +0 +\d+ +\d+ +rf *[\n\r]+', 'start'), 1)
        % Set the line to whitespace and quit
        l(1:regexp(l, '[\n\r]', 'start', 'once')-1) = ' ';
        fseek(fh, -numel(l), 0);
        fprintf(fh, l);
        break;
    end
end
% Close the file
fclose(fh);
return

function b = isvector(options)
b = options.pdf || options.eps;
return

function b = isbitmap(options)
b = options.png || options.tif || options.jpg || options.bmp || options.im || options.alpha;
return

%PRINT2ARRAY  Exports a figure to an image array
%
% Examples:
%   A = print2array
%   A = print2array(figure_handle)
%   A = print2array(figure_handle, resolution)
%   A = print2array(figure_handle, resolution, renderer)
%   [A bcol] = print2array(...)
%
% This function outputs a bitmap image of the given figure, at the desired
% resolution.
%
% If renderer is '-painters' then ghostcript needs to be installed. This
% can be downloaded from: http://www.ghostscript.com
%
% IN:
%   figure_handle - The handle of the figure to be exported. Default: gcf.
%   resolution - Resolution of the output, as a factor of screen
%                resolution. Default: 1.
%   renderer - string containing the renderer paramater to be passed to
%              print. Default: '-opengl'.
%
% OUT:
%   A - MxNx3 uint8 image of the figure.
%   bcol - 1x3 uint8 vector of the background color

% Copyright (C) Oliver Woodford 2008-2011

% 5/9/2011 Set EraseModes to normal when using opengl or zbuffer renderers.
% Thanks to Pawel Kocieniewski for reporting the issue.

% 21/9/2011 Bug fix: unit8 -> uint8!
% Thanks to Tobias Lamour for reporting the issue.

% 14/11/2011 Bug fix: stop using hardcopy(), as it interfered with figure
% size and erasemode settings. Makes it a bit slower, but more reliable.
% Thanks to Phil Trinh and Meelis Lootus for reporting the issues.

function [A bcol] = print2array(fig, res, renderer)
% Generate default input arguments, if needed
if nargin < 2
    res = 1;
    if nargin < 1
        fig = gcf;
    end
end
% Warn if output is large
old_mode = get(fig, 'Units');
set(fig, 'Units', 'pixels');
px = get(fig, 'Position');
set(fig, 'Units', old_mode);
npx = prod(px(3:4)*res)/1e6;
if npx > 30
    % 30M pixels or larger!
    warning('MATLAB:LargeImage', 'print2array generating a %.1fM pixel image. This could be slow and might also cause memory problems.', npx);
end
% Retrieve the background colour
bcol = get(fig, 'Color');
% Set the resolution parameter
res_str = ['-r' num2str(ceil(get(0, 'ScreenPixelsPerInch')*res))];
% Generate temporary file name
tmp_nam = [tempname '.tif'];
if nargin > 2 && strcmp(renderer, '-painters')
    % Print to eps file
    tmp_eps = [tempname '.eps'];
    print2eps(tmp_eps, fig, renderer, '-loose');
    try
        % Export to tiff using ghostscript
        ghostscript(['-dEPSCrop -q -dNOPAUSE -dBATCH ' res_str ' -sDEVICE=tiff24nc -sOutputFile="' tmp_nam '" "' tmp_eps '"']);
    catch
        % Delete the intermediate file
        delete(tmp_eps);
        rethrow(lasterror);
    end
    % Delete the intermediate file
    delete(tmp_eps);
    % Read in the generated bitmap
    A = imread(tmp_nam);
    % Delete the temporary bitmap file
    delete(tmp_nam);
    % Set border pixels to the correct colour
    if isequal(bcol, 'none')
        bcol = [];
    elseif isequal(bcol, [1 1 1])
        bcol = uint8([255 255 255]);
    else
        for l = 1:size(A, 2)
            if ~all(reshape(A(:,l,:) == 255, [], 1))
                break;
            end
        end
        for r = size(A, 2):-1:l
            if ~all(reshape(A(:,r,:) == 255, [], 1))
                break;
            end
        end
        for t = 1:size(A, 1)
            if ~all(reshape(A(t,:,:) == 255, [], 1))
                break;
            end
        end
        for b = size(A, 1):-1:t
            if ~all(reshape(A(b,:,:) == 255, [], 1))
                break;
            end
        end
        bcol = median([reshape(A(:,[l r],:), [], size(A, 3)); reshape(A(:,[t b],:), [], size(A, 3))], 1);
        for c = 1:size(A, 3)
            A(:,[1:l-1, r+1:end],c) = bcol(c);
            A([1:t-1, b+1:end],:,c) = bcol(c);
        end
    end
else
    if nargin < 3
        renderer = '-opengl';
    end
    err = false;
    % Set paper size
    old_mode = get(fig, 'PaperPositionMode');
    set(fig, 'PaperPositionMode', 'auto');
    try
        % Print to tiff file
        print(fig, renderer, res_str, '-dtiff', tmp_nam);
        % Read in the printed file
        A = imread(tmp_nam);
        % Delete the temporary file
        delete(tmp_nam);
    catch ex
        err = true;
    end
    % Reset paper size
    set(fig, 'PaperPositionMode', old_mode);
    % Throw any error that occurred
    if err
        rethrow(ex);
    end
    % Set the background color
    if isequal(bcol, 'none')
        bcol = [];
    else
        bcol = bcol * 255;
        if isequal(bcol, round(bcol))
            bcol = uint8(bcol);
        else
            bcol = squeeze(A(1,1,:));
        end
    end
end
% Check the output size is correct
if isequal(res, round(res))
    px = [px([4 3])*res 3];
    if ~isequal(size(A), px)
        % Correct the output size
        A = A(1:min(end,px(1)),1:min(end,px(2)),:);
    end
end
return
