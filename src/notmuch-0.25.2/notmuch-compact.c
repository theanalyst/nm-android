/* notmuch - Not much of an email program, (just index and search)
 *
 * Copyright © 2013 Ben Gamari
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see https://www.gnu.org/licenses/ .
 *
 * Author: Ben Gamari <bgamari.foss@gmail.com>
 */

#include "notmuch-client.h"

static void
status_update_cb (const char *msg, unused (void *closure))
{
    printf ("%s\n", msg);
}

int
notmuch_compact_command (notmuch_config_t *config, int argc, char *argv[])
{
    const char *path = notmuch_config_get_database_path (config);
    const char *backup_path = NULL;
    notmuch_status_t ret;
    notmuch_bool_t quiet = FALSE;
    int opt_index;

    notmuch_opt_desc_t options[] = {
	{ NOTMUCH_OPT_STRING, &backup_path, "backup", 0, 0 },
	{ NOTMUCH_OPT_BOOLEAN,  &quiet, "quiet", 'q', 0 },
	{ NOTMUCH_OPT_INHERIT, (void *) &notmuch_shared_options, NULL, 0, 0 },
	{ 0, 0, 0, 0, 0}
    };

    opt_index = parse_arguments (argc, argv, options, 1);
    if (opt_index < 0)
	return EXIT_FAILURE;

    if (notmuch_requested_db_uuid) {
	fprintf (stderr, "Error: --uuid not implemented for compact\n");
	return EXIT_FAILURE;
    }

    notmuch_process_shared_options (argv[0]);

    if (! quiet)
	printf ("Compacting database...\n");
    ret = notmuch_database_compact (path, backup_path,
				    quiet ? NULL : status_update_cb, NULL);
    if (ret) {
	fprintf (stderr, "Compaction failed: %s\n", notmuch_status_to_string (ret));
	return EXIT_FAILURE;
    }

    if (! quiet) {
	if (backup_path)
	    printf ("The old database has been moved to %s.\n", backup_path);

	printf ("Done.\n");
    }

    return EXIT_SUCCESS;
}
