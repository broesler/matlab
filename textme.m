function textme(subject,message)
% TEXTME Send a text to Bernie's cell phone (on Sprint network)
%   TEXTME('subject','message') sends message with a subject and a message,
%       input as strings
%   
%   TEXTME('message') sends message with a blank subject
%
%   TEXTME() sends default message with blank subject
%
%   See also SENDMAIL

if nargin == 0
    message = 'Your MATLAB run is complete!';
    subject = '';
elseif nargin == 1
    message = subject;
    subject = '';
end

% Bernie's cell
number = '2015226939';

% Full address 
to = [number, '@messaging.sprintpcs.com'];

% Send text message
sendmail(to, subject, message);

clear number to

end