import hy
from trytond.pool import Pool
from . import hello


def register():
    Pool.register(
        hello.HelloStart,
        hello.HelloSelectUser,
        module='hello_wizard', type_='model')
    Pool.register(
        hello.HelloWizard,
        module='hello_wizard', type_='wizard')
