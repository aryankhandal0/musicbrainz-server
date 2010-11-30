package MusicBrainz::Server::WebService::JSONSerializer;

use Moose;
use JSON;

sub mime_type { 'application/json' }

sub serialize
{
    my ($self, $type, @data) = @_;

    return $self->$type(@data);
}

sub autocomplete_name
{
    my ($self, $list, $current, $pages) = @_;

    my @response = map {
        {
            name => $_->name,
            id => $_->id,
            gid => $_->gid,
            comment => $_->comment,
        }
    } @{$list};

    push @response, {
        pages => $pages,
        current => $current
    };

    return encode_json (\@response);
}

sub generic
{
    my ($self, $response) = @_;

    return encode_json ($response);
}

sub output_error
{
    my ($self, $err) = @_;

    return encode_json ({ error => $err });
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=head1 COPYRIGHT

Copyright (C) 2010 MetaBrainz Foundation

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
