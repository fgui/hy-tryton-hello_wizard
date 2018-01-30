
try:
    from trytond.modules.hello_wizard.tests.test_hello_wizard import suite
except ImportError:
    from .test_hello_wizard import suite

__all__ = ['suite']
