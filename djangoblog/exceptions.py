class DjangoblogException(Exception):

    """Base djangoblog exception."""


class UserAlreadyExist(DjangoblogException):

    """User already exist."""
