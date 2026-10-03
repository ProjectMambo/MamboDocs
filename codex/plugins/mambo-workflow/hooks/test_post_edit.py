from pathlib import Path
import unittest
from unittest import mock

import post_edit


class PostEditTests(unittest.TestCase):
    def test_extracts_apply_patch_paths(self) -> None:
        payload = {
            "cwd": "/workspace/repo",
            "tool_input": {
                "command": "*** Update File: README.md\n*** Add File: docs/Guide.md\n"
            },
        }

        self.assertEqual(
            post_edit.absolute_paths(payload),
            [Path("/workspace/repo/README.md"), Path("/workspace/repo/docs/Guide.md")],
        )

    def test_maps_project_and_site_sources(self) -> None:
        root = Path("/workspace/ProjectMambo")
        paths = [
            root / "notes/Docs/Projects/MamboTools/README.md",
            root / "notes/Docs/Projects/_sites/MamboWiki/index.md",
        ]

        self.assertEqual(
            post_edit.canonical_projects(paths, root),
            {"MamboTools", "MamboWiki"},
        )

    def test_mixed_profile_and_project_edit_still_syncs_wiki(self) -> None:
        self.assertEqual(
            post_edit.sync_selection({"ProjectMambo", "MamboTools"}),
            ["MamboTools", "ProjectMambo", "MamboWiki"],
        )

    def test_profile_only_does_not_sync_wiki(self) -> None:
        self.assertEqual(
            post_edit.sync_selection({"ProjectMambo"}),
            ["ProjectMambo"],
        )

    @mock.patch("post_edit.subprocess.run")
    def test_originless_non_mambo_repository_is_out_of_scope(self, run: mock.Mock) -> None:
        run.return_value = mock.Mock(returncode=2, stdout="")

        self.assertFalse(
            post_edit.is_mambo_repository(
                Path("/workspace/ProjectMambo/Utility"),
                Path("/workspace/ProjectMambo"),
            )
        )
        run.assert_called_once()

    @mock.patch("post_edit.subprocess.run")
    def test_only_uninitialized_originless_mambo_repository_is_in_scope(
        self, run: mock.Mock
    ) -> None:
        run.side_effect = [
            mock.Mock(returncode=2, stdout=""),
            mock.Mock(returncode=128, stdout=""),
            mock.Mock(returncode=2, stdout=""),
            mock.Mock(returncode=0, stdout="commit"),
        ]
        root = Path("/workspace/ProjectMambo")
        repository = root / "MamboNew"

        self.assertTrue(post_edit.is_mambo_repository(repository, root))
        self.assertFalse(post_edit.is_mambo_repository(repository, root))


if __name__ == "__main__":
    unittest.main()
